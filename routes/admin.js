const express = require("express");
const router = express.Router();

const mysql = require('mysql2');
// Assuming the encryptionUtil.js file is in the same directory

const db = require('../models');
const { where } = require('sequelize');
const Staff = db.Staff;
const UserUtil = require('../util/userUtil');


// router.get("/dashboard", (req, res) => {
// 	res.render("admindashboard");
// });

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

router.post('/insert-customer-rep', async (req, res) => {

    //Cookie-Presence check. TODO can be used further to validate user.
    console.log(req.cookies);
    
    // Get data from request
    const staffData = req.body;
    const Staff = db.Staff;

    staffData.userId = '1'
    staffData.status = 'A'; // Example value
    staffData.created_on = new Date();
    staffData.created_by = 'Admin';
    staffData.remarks = 'No remarks'; // Example value
    staffData.updated_by = 'Admin';
    staffData.updated_on = new Date();

    console.log(staffData);
    

    try {
        
        const staff = await Staff.create(staffData);
        // Handle the response after success
        res.redirect('/admin/dashboard');  // Redirect to login or any other page
    } catch (error) {
        // Handle the error response
        console.error('Error occurred:', error);
        res.status(500).send('Error occurred');
    }
});

module.exports = router;