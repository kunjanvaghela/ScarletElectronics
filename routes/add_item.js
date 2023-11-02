const express = require("express");
const router = express.Router();

const mysql = require('mysql2');
// Assuming the encryptionUtil.js file is in the same directory

const db = require('../models');
const { where } = require('sequelize');
const Catalog = db.Catalog;


router.get("/add", (req, res) => {
    console.log('Successfully in Root :Inssss:sss:: /');
    res.render('add-item');
});


router.post('/insert', async (req, res) => {
    // Get data from request
    const catalogData = req.body;
    const Catalog = db.Catalog;

    catalogData.listing_Status = 'Active'; // Example value
    catalogData.approval_Status = 'Approved'; // Example value
    catalogData.created_on = new Date();
    catalogData.remarks = 'No remarks'; // Example value
    catalogData.updated_on = new Date();

    console.log(catalogData);
    

    try {
        
        const catalog = await Catalog.create(catalogData);
        // Handle the response after success
        res.redirect('add');  // Redirect to login or any other page
    } catch (error) {
        // Handle the error response
        console.error('Error occurred:', error);
        res.status(500).send('Error occurred');
    }
});



module.exports = router;