const express = require("express");
const router = express.Router();

const mysql = require('mysql2');
// Assuming the encryptionUtil.js file is in the same directory

const db = require('../models');
const { where } = require('sequelize');
const Catalog = db.Catalog;
const UserUtil = require('../util/userUtil');


router.get("/add", async (req, res) => {
    console.log('Successfully in /add-item/add');
    if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
        // If not authenticated, send a 401 Unauthorized response
        return res.status(401).send('Authentication failed');
    }
    const userDetails = await UserUtil.check_email(req.cookies.emailId);
    const username = userDetails.name;
    console.log('username : ',  username);
    res.render('additem', { username });
});

// // Category selection route
// router.post('/insert-category', async (req, res) => {
//     const selectedCategory = req.body.category;

//     // Render the appropriate form based on the selected category
//     res.render('additem', { selectedCategory });
// });

// Insert data into the database based on the selected category
router.post('/insert', async (req, res) => {
    const catalogData = req.body;
    catalogData.listing_Status = 'Active'; // Example value
    catalogData.approval_Status = 'Approved'; // Example value
    catalogData.created_on = new Date();
    catalogData.remarks = 'No remarks'; // Example value
    catalogData.updated_on = new Date();
    console.log(catalogData);

    try {
        // Get the user details using the emailId from the cookie
        const userDetails = await UserUtil.check_email(req.cookies.emailId);
        const userid = userDetails.userId;

        // Add created_by to catalogData
        catalogData.created_by = userid;
        const catalog = await Catalog.create(catalogData);
        // Handle the response after success
        res.redirect('/item-listing');  // Redirect to the item listing or any other page
    } catch (error) {
        // Handle the error response
        console.error('Error occurred:', error);
        res.status(500).send('Error occurred');
    }
});

module.exports = router;