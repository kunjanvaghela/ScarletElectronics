const express = require("express");
const router = express.Router();
const send_otp_routes = require("./otp_routes");
const recover_pass_routes =require("./recover_pass_routes");
const mysql = require('mysql2');
const { encrypt, decrypt } = require('../util/encryptionUtil'); // Assuming the encryptionUtil.js file is in the same directory

const db = require('../models');
const { where } = require('sequelize');
const EndUser = db.EndUsers;
const User = db.User;
const OTP = db.OTP;

router.get("/Home_Landing", (req, res) => {
    console.log('Successfully in Root :Inssss:sss:: /');
    res.render('Home_Landing');
});

router.get("/", (req, res) => {
    console.log('Successfully in Landing Page');
    res.render('index_Landing');
});

router.get('/login', (req, res) => {
    console.log('Successfully in Root :Inssss:sss:: /');
    res.render('loginPage');

})

router.get('/register', (req, res) => {
    res.render('register');
});

router.get('/cart', (req, res) => {
    const fields = [
      { name: 'email', label: 'Email', type: 'text' },
      { name: 'password', label: 'Password', type: 'password' },
      // Add more fields as needed
    ];
  
    res.render('cartPage', { fields });
});

router.get('/checkout', (req, res) => {
    const itemsArray = [
        { item: 'item1', qty: 2, cost_qty: 10 , cost_item: 10 },
        { item: 'item2', qty: 1, cost_qty: 5 , cost_item: 10 },
        // Add more items as needed
    ];
  
    res.render('checkoutPage', { itemsArray });
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
        // const user = await User.create(userData);
        await User.create(userData).then((user) => {
            userData.userId = user.userid;
            console.log("User Inserted, now have to insert EndUser");
            console.log(userData);
            EndUser.create(userData);

        });

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

        // Calculate the expiration time as the current time + 10 minutes
        const tenMinutes = 1000 * 60 * 120; // 10 minutes in milliseconds
        const expiresAt = new Date(Date.now() + tenMinutes);
        
        // Handle the response after success
        res.cookie('emailId', user.emailId, {
            expires : expiresAt,
            httpOnly: true
        });

        // return res.status(200).json({ message: 'Welcome '+user.name+',  Login successful' });
      // return res.status(201).redirect('/users/Home_Landing');  // Manad's redirection
        return res.status(200).render('seller_listing');

    } catch (error) {
        console.error('Error during login:', error);
        return res.status(401).render("loginPage" , {message: 'Login Failed Please use valid Credentials'});
    }
});

router.use('/send-otp', send_otp_routes);
router.use('/recover-password', recover_pass_routes);

module.exports = router;