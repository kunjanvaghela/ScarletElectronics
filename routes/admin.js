const express = require("express");
const router = express.Router();

const mysql = require('mysql2');
// Assuming the encryptionUtil.js file is in the same directory

const db = require('../models');
const { where } = require('sequelize');
const Staff = db.Staff;
const User = db.User;
const UserUtil = require('../util/userUtil');



router.get("/dashboard", async (req, res) => {
    console.log('Successfully in /admin/dashboard');
    const userDetails = await UserUtil.check_email(req.cookies.emailId);
    const username = userDetails.name;
    console.log('username : ',  username);
    res.render('admindashboard', { username });
    
});

router.get("/customer-rep", async (req, res) => {
    const userDetails = await UserUtil.check_email(req.cookies.emailId);
    const username = userDetails.name;
    console.log('username : ',  username);
    res.render('CreateCustomerRep', { username });
    
});

// router.post('/insert-customer-rep', async (req, res) => {

//     //Cookie-Presence check. TODO can be used further to validate user.
//     console.log(req.cookies);
//     console.log('Receievd data:', req.body)
    
//     // Get data from request
//     const userData = req.body;
//     const User = db.User;
//     console.log(userData);

//     try {
        
//         await User.create(userData).then((user) => {
//             userData.userId = user.userid;
//             console.log("User Inserted, now have to insert staffUser");
//             console.log(userData);
//             Staff.create(userData);
//         });
//         // return res.status(200).json({
// 		// 	success: true,
// 		// 	// message: "Welcome " + User.name + ",  Registration Successful",
// 		// });
//         // Handle the response after success
//          res.redirect('/admin/dashboard');  // Redirect to login or any other page
//     } catch (error) {
//         // Handle the error response
//         console.error('Error occurred:', error);
//         res.status(500).send('Error occurred');
//     }
// });

router.post('/insert-customer-rep', async (req, res) => {
    // Cookie-Presence check. TODO can be used further to validate user.
    console.log(req.cookies);
    console.log('Received data:', req.body);

    // Get data from request
    const userData = req.body;
    const User = db.User;
    console.log(userData);

    try {
        await User.create(userData).then((user) => {
            userData.userId = user.userid;
            console.log("User Inserted, now have to insert staffUser");
            console.log(userData);
            Staff.create(userData);
        });

        // Instead of redirecting, send a JSON response
        res.status(200).json({
            success: true,
            // redirectTo: '/admin/dashboard', // Include the desired redirection path
        });
    } catch (error) {
        console.error('Error occurred:', error);
        res.status(500).json({
            success: false,
            message: 'Error occurred',
        });
    }
});


module.exports = router;