const express = require("express");
const router = express.Router();

const db = require('../models');
const { where } = require('sequelize');
const Catalog = db.Catalog;
const ItemListing = db.ItemListing;
const UserUtil = require('../util/userUtil');
const GoogleDriveUtil = require('../util/googleDriveUtil');

const getItemListings = async (req, res) => {
  console.log('in item_listing_routes.js route :/ ');

  // Check if the user is authenticated
  if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
    // If not authenticated, send a 401 Unauthorized response
    return res.status(401).send('Authentication failed');
  }

  try {
    console.log('in TRY');
    // Retrieve user details
    const payload = UserUtil.retrieveTokenPayload(req.cookies.accessToken);
		console.log("ACCESSING USERID FROM TOKENPAAYLOAD:", payload.userId);
    console.log("ACCESSING emailId FROM TOKENPAAYLOAD:", payload.emailId);
    const userDetails = await UserUtil.check_email(payload.emailId);
    const username = userDetails.name;

    const listings = await ItemListing.findAll({
        where: {
            price: db.sequelize.literal('ItemListing.price = (SELECT MIN(price) FROM item_listing AS il WHERE il.itemId = ItemListing.itemId)'),
        },
        include: [Catalog],
    });

    const serializedListings = await Promise.all(listings.map(async (listing) => {
        let imageFiles = [{"id" : "NoImage"}];
        if (listing.Catalog.itemImage) {
            imageFiles = await GoogleDriveUtil.getImagesInFolder(listing.Catalog.itemImage);
        }
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
            rear_camera: listing.Catalog.rear_camera,
            imageFiles: imageFiles,
        };
    }));

    console.log("serializedListings : " + serializedListings)
    return res.status(200).json({
			success: true,
			message: "Item Listings retrieved.",
      serializedListings: serializedListings,
      username: username,
      redirectUrl: "/item-listing/listings"
		});
    // res.render('listings', { serializedListings, username });
  } catch (error) {
      console.error('Error retrieving data:', error);
      res.status(400).send('Unable to fetch the listings');
  }

}

const getProductInformation = async (req, res) => {
  console.log('Working');
  try {
  console.log(req.cookies.emailId);
  if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
    // If not authenticated, send a 401 Unauthorized response
    return res.status(401).send('Authentication failed');
  }
  //UTILIZING THE JWT : UNPACKAGING ENCRYPTED DATA

  //CURRENT IMPLEMENTATION (DIRECTLY FETCHES EMAIL ID FROM COOKIE {INCORRECT & VULNERABLE})
  //userDetails = await UserUtil.check_email(req.cookies.emailId);
  
  //NEW IMPLEMENTATION -RETURNS THE ORIGINAL PAYLOAD OBJECT (DECIPHERS THE JSON PACKAGE : EMAIL AND USERID FROM THE ENCRYPTED JWT PAYLOAD)
  const payload = UserUtil.retrieveTokenPayload(req.cookies.accessToken);
  //THIS IS HOW YOU CAN ACCESS THE PAYLOAD OBJECT
  console.log("ACCESSING USERID FROM TOKENPAAYLOAD:", payload.userId);
  console.log("ACCESSING emailId FROM TOKENPAAYLOAD:", payload.emailId);
  //USING THE EMAIL ID FROM PAYLOAD OBJECT
  userDetails = await UserUtil.check_email(payload.emailId);

  console.log(userDetails.userid);
  const username = userDetails.name;
    const itemId = req.query['item-id'];

    const product = await Catalog.findOne({
        where: { itemId },
        include: [{
          model: ItemListing,
          attributes: ['listingId', 'price', 'quantity'],
        }],
    });

    if (!product) {
      console.log('Product not found');
      // res.status(404).send('Product not found');
      // return;
      return res.status(404).json({
        success: false,
        message: "Product not found",
        redirectUrl: "/item-listing/listings"
      });
    }
    
    // Adding imageFiles
    console.log("product.itemImage : "+ product.itemImage);
    let imageFiles = ['Null'];
    if (product.itemImage) {
      imageFiles = await GoogleDriveUtil.getImagesInFolder(product.itemImage);
      console.log("Got imageFiles value in if : " + imageFiles);
    }
    console.log("Got imageFiles value after if : "+ imageFiles);
    
    // console.log('product : ', product);
    // console.log('product.ItemListings : ', product.ItemListings);
    // return res.status(200).json({
		// 	success: true,
		// 	message: "Item Information retrieved.",
    //   product: product,
    //   username: username,
    //   imageFiles: imageFiles,
		// });
    res.render('product', {product, username, imageFiles});
  } catch (error) {
    console.error('Error retrieving data:', error);
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      redirectUrl: "/item-listing/listings"
    });
  }
  
}

const getAllProducts = async (req, res) => {
  console.log('Button Working');
  if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
    // If not authenticated, send a 401 Unauthorized response
    return res.status(401).send('Authentication failed');
  }
  userDetails = await UserUtil.check_email(req.cookies.emailId);
  console.log(userDetails.userid);
  const username = userDetails.name;
  const item_listing = Catalog.findAll().then(function(Catalog){
      
      // return res.status(200).json({
      //   success: true,
      //   message: "Item Information retrieved.",
      //   catalog: Catalog,
      // });
      res.render('seller_listing', {Catalog, username});
      //console.log(Catalog);
      
    }).catch(function(err){
      console.log('Oops! something went wrong, : ', err);
    });
  //console.log(item_listing);
  //console.log(typeof(item_listing));
  
}

const createItemListing = async (req, res) => {
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
      // return res.status(200).json({
      //   success: true,
      //   message: "Item Listing created."
      // });
      res.redirect('/item-listing/listings');  // Redirect to login or any other page
  } catch (error) {
      // Handle the error response
      console.error('Error occurred:', error.message);
      res.status(500).send('Error occurred: ' + error.message);
  }
}

router.get("/", getItemListings);

router.get("/listings", async (req, res) => {
  res.render('listings');
})

router.get("/product", getProductInformation);

router.get("/create", async (req, res) => {
  console.log('Working');
  console.log(req.cookies.emailId);
  userDetails = await UserUtil.check_email(req.cookies.emailId);
  console.log(userDetails.userid);
  const username = userDetails.name;

  // console.log(req.cookies['emailId']);
  console.log("Cookie must have been displayed!");
  res.render('seller_listing', { username });
});


router.get("/get-existing-listing", getAllProducts);

router.post('/create', createItemListing);

module.exports = router;