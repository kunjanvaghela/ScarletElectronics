const express = require("express");
const router = express.Router();
const send_otp_routes = require("./otp_routes");
const recover_pass_routes =require("./recover_pass_routes");
const mysql = require('mysql2');
const { encrypt, decrypt } = require('../util/encryptionUtil'); // Assuming the encryptionUtil.js file is in the same directory

const db = require('../models');
const { where } = require('sequelize');
const User = db.User;
const OTP = db.OTP;

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

router.post('/registerUser', async (req, res) => {
    // Get data from request
    const userData = req.body;
    const User = db.User;
   // console.log(userData['emailId']);

    try {
        //const existing = await User.findOne(userData.emailId)
        const user = await User.create(userData);
        // Handle the response after success
        res.redirect('Home_Landing');  // Redirect to login or any other page
    } catch (error) {
        // Handle the error response
        console.error('Error occurred:', error);
        res.status(409).render("loginPage", {message : "Email alredy exists in the system, Please Login or use Forget Password Option."});
       // res.status(500).send('Error occurred');
    }
});

router.post('/login', async (req, res) => {
    // Get data from request
    const { emailId, password } = req.body;

    const User = db.User;

    try {
        const user = await User.findOne({ where: { emailId } });

        if (!user) {
            return res.status(404).render("loginPage", { message: 'You do not exists in our system. Please Sign up' });
        }

        const decryptedPassword = decrypt(user.encrypted_password);

        if (password !== decryptedPassword) {
            return res.status(401).render("loginPage", { message: 'Wrong Password. Please try again!' });
        }

        return res.status(201).redirect('/users/Home_Landing');

    } catch (error) {
        console.error('Error during login:', error);
        return res.status(401).render("loginPage" , {message: 'Login Failed Please use valid Credentials'});
    }
});

router.use('/send-otp', send_otp_routes);
router.use('/recover-password', recover_pass_routes);

module.exports = router;