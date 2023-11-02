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
    const item_listing = Catalog.findAll().then(function(Catalog){
        
        res.render('seller_listing', {Catalog});
        //console.log(Catalog);
        
      }).catch(function(err){
        console.log('Oops! something went wrong, : ', err);
      });
    //console.log(item_listing);
    //console.log(typeof(item_listing));
    
});

router.post('/create', async (req, res) => {
  // Get data from request
  const itemListingData = req.body;
  const ItemListing = db.ItemListing;
  itemListingData.sellerId = 15; // Temporary
  console.log(itemListingData);

  try {
      // const user = await User.create(userData);
      await ItemListing.create(itemListingData);
      // Handle the response after success
      res.redirect('/item-listing');  // Redirect to login or any other page
  } catch (error) {
      // Handle the error response
      console.error('Error occurred:', error);
      res.status(500).send('Error occurred');
  }
});

module.exports = router;