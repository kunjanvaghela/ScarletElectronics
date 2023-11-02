const express = require("express");
const router = express.Router();

const mysql = require('mysql2');
// Assuming the encryptionUtil.js file is in the same directory

const db = require('../models');
const { where } = require('sequelize');
const Catalog = db.Catalog;




router.post('/add-item/insert', async (req, res) => {
    // Get data from request
    const CatalogData = req.body;
    const Catalog = db.Catalog;
    console.log(CatalogData);

    try {
        const Catalog = await Catalog.create(CatalogData);
        // Handle the response after success
        res.redirect('add-item/insert');  // Redirect to login or any other page
    } catch (error) {
        // Handle the error response
        console.error('Error occurred:', error);
        res.status(500).send('Error occurred');
    }
});



module.exports = router;