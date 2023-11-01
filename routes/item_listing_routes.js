const express = require("express");
const router = express.Router();

const db = require('../models');
const { where } = require('sequelize');
const Catalog = db.Catalog;

router.get("/", (req, res) => {
    console.log('Working');
    res.render('seller_listing');
});

router.get("/get-existing-listing", (req, res) => {
    console.log('Button Working');
    //const item_listing = await Catalog.findAll();
    res.render('seller_listing');
});

module.exports = router;