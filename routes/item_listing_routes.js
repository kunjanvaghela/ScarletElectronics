const express = require("express");
const router = express.Router();

const db = require('../models');
const { where } = require('sequelize');
const Catalog = db.Catalog;
const ItemListing = db.ItemListing;
const UserUtil = require('../util/userUtil');

router.get("/", async (req, res) => {
  console.log('Working0');

  // Check if the user is authenticated
  if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
    // If not authenticated, send a 401 Unauthorized response
    return res.status(401).send('Authentication failed');
  }

  try {
    console.log('Working2');
    // Retrieve user details
    const userDetails = await UserUtil.check_email(req.cookies.emailId);
    const username = userDetails.name;

    // Find all item listings with their catalog details
    const listings = await ItemListing.findAll({ include: [Catalog] });

    // Serialize the listings data
    const serializedListings = listings.map(listing => {
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

    // Render the listings page with the serialized data and username
    res.render('listings', { serializedListings, username });
  } catch (error) {
    // Log the error and send a 500 Internal Server Error response
    console.error('Error retrieving data:', error);
    res.status(500).send('Internal server error');
  }
});

router.get("/create", async (req, res) => {
  console.log('Working');
  console.log(req.cookies.emailId);
  if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
    // If not authenticated, send a 401 Unauthorized response
    return res.status(401).send('Authentication failed');
  }

  userDetails = await UserUtil.check_email(req.cookies.emailId);
  console.log(userDetails.userid);
  const username = userDetails.name;

  // console.log(req.cookies['emailId']);
  console.log("Cookie must have been displayed!");
  res.render('seller_listing', { username });
});

router.get("/get-existing-listing", async (req, res) => {
  console.log('Button Working');
  if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
    // If not authenticated, send a 401 Unauthorized response
    return res.status(401).send('Authentication failed');
  }
  userDetails = await UserUtil.check_email(req.cookies.emailId);
  console.log(userDetails.userid);
  const username = userDetails.name;
  const item_listing = Catalog.findAll().then(function (Catalog) {

    res.render('seller_listing', { Catalog, username });
    //console.log(Catalog);

  }).catch(function (err) {
    console.log('Oops! something went wrong, : ', err);
  });
  //console.log(item_listing);
  //console.log(typeof(item_listing));

});

router.post('/create', async (req, res) => {
  // Get data from request
  const itemListingData = req.body;
  // itemListingData.sellerId = 15; // Temporary
  if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
    // If not authenticated, send a 401 Unauthorized response
    return res.status(401).send('Authentication failed');
  }
  userDetails = await UserUtil.check_email(req.cookies.emailId);
  console.log(userDetails.userid);
  itemListingData.sellerId = userDetails.userid;
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