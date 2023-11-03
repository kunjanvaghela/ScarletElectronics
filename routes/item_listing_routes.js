const express = require("express");
const router = express.Router();

const db = require('../models');
const { where } = require('sequelize');
const Catalog = db.Catalog;
const ItemListing = db.ItemListing;
const UserUtil = require('../util/userUtil');

router.get("/", (req, res) => {
  console.log('Working');

  ItemListing.findAll({
    include: [Catalog],
  }).then((listings) => {
    const serializedListings = listings.map((listing) => {
      return {
        listingId: listing.listingId,
        price: listing.price,
        quantity: listing.quantity,
        sellerId: listing.sellerId,
        itemId: listing.Catalog.itemId,
        name: listing.Catalog.name,
        description: listing.Catalog.description,
        category: listing.Catalog.category,
        cpu: listing.Catalog.cpu,
        gpu: listing.Catalog.gpu,
        ram: listing.Catalog.ram,
        storage: listing.Catalog.storage,
        operating_system: listing.Catalog.operating_system,
        screen_size: listing.Catalog.screen_size,
        screen_type: listing.Catalog.screen_type,
        screen_resolution: listing.Catalog.screen_resolution,
        front_camera: listing.Catalog.front_camera,
        rear_camera: listing.Catalog.rear_camera
      };
    });

    // Send the serialized data as a response
    res.render('listings', {serializedListings});
    // res.render('seller_listing', {serializedListings})
  }).catch((error) => {
    console.error('Error retrieving data:', error);
    res.status(500).send('Internal server error');
  });


  // res.render('listings');
});

router.get("/create", async (req, res) => {
  console.log('Working');
  console.log(req.cookies.emailId);
  userDetails = await UserUtil.check_email(req.cookies.emailId);
  console.log(userDetails.userid);
  // console.log(req.cookies['emailId']);
  console.log("Cookie must have been displayed!");
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
  itemListingData.sellerId = 15; // Temporary
  req.cookies;
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