const express = require("express");
const router = express.Router();

const db = require('../models');
const { where } = require('sequelize');
const Catalog = db.Catalog;

router.get("/", (req, res) => {
    console.log('Working');
    res.render('seller_listing', Catalog);
});

router.get("/get-existing-listing", (req, res) => {
    console.log('Button Working');
    const item_listing = Catalog.findAll().then(function(Catalog){
        
        res.render('seller_listing', {Catalog});
        //console.log(Catalog);
        
      }).catch(function(err){
        console.log('Oops! something went wrong, : ', err);
      });
    //console.log(item_listing);
    //console.log(typeof(item_listing));
    
});

module.exports = router;