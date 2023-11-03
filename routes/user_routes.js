const express = require("express");
const router = express.Router();
const send_otp_routes = require("./otp_routes");
const recover_pass_routes = require("./recover_pass_routes");
const axios = require('axios'); // Required for reCAPTCHA verification
const db = require('../models');
const { encrypt, decrypt } = require('../util/encryptionUtil');

const multer = require('multer');
const upload = multer();

router.get("/Home_Landing", (req, res) => {
    console.log('Successfully in Root :Inssss:sss:: /');
    res.render('Home_Landing');
});

router.get('/login', (req, res) => {
    console.log('Successfully in Root :Inssss:sss:: /');
    res.render('loginPage');
})

router.get('/register', (req, res) => {
    res.render('register');
});

router.get('/forgot-password', (req, res, next) => {
    res.render('forgot-password');
});

router.post('/registerUser',upload.none(), async (req, res) => {
    const recaptchaResponse = req.body['g-recaptcha-response'];
    console.log("IN REGISTER USER NOW WILL PRINT REQ")
    console.log(req)
    // Check if CAPTCHA response is present
    if (!recaptchaResponse) {
        return res.status(400).json({ message: 'Please complete the CAPTCHA.BACKEND' });
    }

    try {
        // Verify reCAPTCHA
        const verificationURL = `https://www.google.com/recaptcha/api/siteverify?secret=6Lffbu8oAAAAAHnr8NxZtRoP9-f7367MM9S_MjtN&response=${recaptchaResponse}`;
        const verificationResponse = await axios.post(verificationURL);

        if (!verificationResponse.data.success) {
            return res.status(400).send('CAPTCHA verification failed.');
        }

        const userData = req.body;
        const User = db.User;
        console.log(userData);

        // await User.create(userData).then((user) => {
        //     userData.userId = user.userid;
        //     console.log("User Inserted, now have to insert EndUser");
        //     console.log(userData);
        //     //EndUser.create(userData);
        // });

        return res.status(200).json({ message: 'Welcome ' + User.name + ',  Registration Successful' });

    } catch (error) {
        console.error('Error occurred:', error);
        res.status(500).send('Error occurred');
    }
});

router.post('/login', async (req, res) => {
    const { emailId, password } = req.body;
    const User = db.User;

    const recaptchaResponse = req.body['g-recaptcha-response'];
    console.log(req)
    // Check if CAPTCHA response is present
    if (!recaptchaResponse) {
        return res.status(400).json({ message: 'Please complete the CAPTCHA.' });
    }

    try {
        // Verify reCAPTCHA
        const verificationURL = `https://www.google.com/recaptcha/api/siteverify?secret=6Lffbu8oAAAAAHnr8NxZtRoP9-f7367MM9S_MjtN&response=${recaptchaResponse}`;
        const verificationResponse = await axios.post(verificationURL);

        if (!verificationResponse.data.success) {
            return res.status(400).json({ message: 'CAPTCHA verification failed.' });
        }

        const user = await User.findOne({ where: { emailId } });

        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        const decryptedPassword = decrypt(user.encrypted_password);

        if (password !== decryptedPassword) {
            return res.status(401).json({ message: 'You have entered an Invalid password, ' + user.name });
        }

        return res.status(200).json({ message: 'Welcome ' + user.name + ',  Login successful' });

    } catch (error) {
        console.error('Error during login:', error);
        return res.status(500).json({ message: 'Internal Server Error' });
    }
});

router.use('/send-otp', send_otp_routes);
router.use('/recover-password', recover_pass_routes);

module.exports = router;
