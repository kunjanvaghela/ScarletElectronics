const express = require("express");
const router = express.Router();

const db = require('../models');
const { where } = require('sequelize');
const Catalog = db.Catalog;
const ItemListing = db.ItemListing;
const UserUtil = require('../util/userUtil');
const { Sequelize } = require('sequelize');
const GoogleDriveUtil = require('../util/googleDriveUtil');
const e = require("express");

const getItemListings = async (req, res) => {
  console.log('in item_listing_routes.js route :/ ');
  console.log("BODY " , req.query);
  let listings;

  if (Object.keys(req.query).length === 0 && req.query.constructor === Object) {
    listings = await ItemListing.findAll({
        where: {
            price: db.sequelize.literal('ItemListing.price = (SELECT MIN(price) FROM item_listing AS il WHERE il.itemId = ItemListing.itemId)'),
        },
        include: [Catalog],
    });
  } else {
    listings = await ItemListing.findAll({
        where: {
            price: db.sequelize.literal('ItemListing.price = (SELECT MIN(price) FROM item_listing AS il WHERE il.itemId = ItemListing.itemId)'),
        },
        include: [{
          model: Catalog,
          where: {
            category: req.query.category,
            storage: req.query.storage
          }
        }],
    });
  }

  // Check if the user is authenticated
  // if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
  //   // If not authenticated, send a 401 Unauthorized respons
  //   return res.status(401).json({
  //     success: false,
  //     message: "Authentication failed",
  //     redirectUrl: "/item-listing/listings"
  //   });
  // }

  try {
    // Retrieve user details
    // const payload = UserUtil.retrieveTokenPayload(req.cookies.accessToken);
		// console.log("ACCESSING USERID FROM TOKENPAAYLOAD:", payload.userId);
    // console.log("ACCESSING emailId FROM TOKENPAAYLOAD:", payload.emailId);
    // const userDetails = await UserUtil.check_email(payload.emailId);
    // const username = userDetails.name;

    // const listings = await ItemListing.findAll({
    //     where: {
    //         price: db.sequelize.literal('ItemListing.price = (SELECT MIN(price) FROM item_listing AS il WHERE il.itemId = ItemListing.itemId)'),
    //     },
    //     include: [Catalog],
    // });

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
    // return {
		// 	success: true,
		// 	message: "Item Listings retrieved.",
    //   serializedListings: serializedListings,
    //   redirectUrl: "/item-listing/listings"
    // };

    return res.status(200).json({
			success: true,
			message: "Item Listings retrieved.",
      serializedListings: serializedListings,
      redirectUrl: "/item-listing/listings"
		});
    // res.render('listings', { serializedListings, username });
  } catch (error) {
      console.error('Error retrieving data:', error);
      return res.status(400).json({
        success: false,
        message: "Unable to fetch the listings.",
        redirectUrl: "/item-listing/listings"
      });
  }

}

const getProductInformation = async (req, res) => {
  console.log('Working');
  try {
    // console.log(req.cookies.emailId);
    // if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
    //   // If not authenticated, send a 401 Unauthorized response
    //   return res.status(401).json({
    //     success: false,
    //     message: "Authentication failed",
    //     redirectUrl: "/item-listing/listings"
    //   });
    // }
    //UTILIZING THE JWT : UNPACKAGING ENCRYPTED DATA

    //CURRENT IMPLEMENTATION (DIRECTLY FETCHES EMAIL ID FROM COOKIE {INCORRECT & VULNERABLE})
    //userDetails = await UserUtil.check_email(req.cookies.emailId);
    
    //NEW IMPLEMENTATION -RETURNS THE ORIGINAL PAYLOAD OBJECT (DECIPHERS THE JSON PACKAGE : EMAIL AND USERID FROM THE ENCRYPTED JWT PAYLOAD)
    // const payload = UserUtil.retrieveTokenPayload(req.cookies.accessToken);
    // //THIS IS HOW YOU CAN ACCESS THE PAYLOAD OBJECT
    // console.log("ACCESSING USERID FROM TOKENPAAYLOAD:", payload.userId);
    // console.log("ACCESSING emailId FROM TOKENPAAYLOAD:", payload.emailId);
    // //USING THE EMAIL ID FROM PAYLOAD OBJECT
    // userDetails = await UserUtil.check_email(payload.emailId);

    // console.log(userDetails.userid);
    // const username = userDetails.name;
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
        return res.status(404).json({
          success: false,
          message: "Product not found",
          redirectUrl: "/item-listing/listings"
        });
      }
      
      console.log("product.itemImage : "+ product.itemImage);
      let imageFiles = ['Null'];
      if (product.itemImage) {
        imageFiles = await GoogleDriveUtil.getImagesInFolder(product.itemImage);
        console.log("Got imageFiles value in if : " + imageFiles);
      }
      console.log("Got imageFiles value after if : "+ imageFiles);
      
      return res.status(200).json({
        success: true,
        message: "Item Information retrieved.",
        product: product,
        imageFiles: imageFiles,
      });
      // res.render('product', {product, username, imageFiles});
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
  // if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
  //   // If not authenticated, send a 401 Unauthorized response
  //   return res.status(401).send('Authentication failed');
  // }
  // userDetails = await UserUtil.check_email(req.cookies.emailId);
  // console.log(userDetails.userid);
  // const username = userDetails.name;
  console.log("BODY " , req.query);

  try {
    let item_listing;
    if (Object.keys(req.query).length === 0 && req.query.constructor === Object) {
      item_listing = await Catalog.findAll();
    } else {
      item_listing = await Catalog.findAll({
        where: {
          category: req.query.category
        }
      });
    }

    return res.status(200).json({
      success: true,
      message: "Item Information retrieved.",
      body: item_listing
    });

    // const item_listing = Catalog.findAll().then(function(Catalog){
        
    //     return res.status(200).json({
    //       success: true,
    //       message: "Item Information retrieved.",
    //       catalog: Catalog,
    //     });
    //     // res.render('seller_listing', {Catalog, username});
    //     //console.log(Catalog);
        
    //   }).catch(function(err){
    //     console.log('Oops! something went wrong, : ', err);
    //   });
    //console.log(item_listing);
    //console.log(typeof(item_listing));
    
  
  } catch (error) {
    console.error('Error retrieving data:', error);
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      redirectUrl: "/item-listing/listings"
    });
  }

}

const createItemListing = async (req, res) => {
  // Get data from request
  const itemListingData = req.body;
  // itemListingData.sellerId = 15; // Temporary
  if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
    // If not authenticated, send a 401 Unauthorized response
    return res.status(401).json({
      success: false,
      message: "Authentication failed",
      redirectUrl: "/item-listing/listings"
    });
  }
  try {
    if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
      // If not authenticated, send a 401 Unauthorized response
      return res.status(401).json({
        success: false,
        message: "Authentication failed",
        redirectUrl: "/item-listing/listings"
      });
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
    itemListingData.sellerId = userDetails.userid;
    console.log(itemListingData);

    try {
        // const user = await User.create(userData);
        await ItemListing.create(itemListingData);
        // Handle the response after success
        return res.status(201).json({
          success: true,
          message: "Item Listing created."
        });
        // res.redirect('/item-listing/listings');  // Redirect to login or any other page
    } catch (error) {
        // Handle the error response
        console.error('Error occurred:', error.message);
        // res.status(500).send('Error occurred: ' + error.message);
        return res.status(500).json({
          success: false,
          message: "Error occured: " + error.message,
          redirectUrl: "/item-listing/listings"
        });
    }
  } catch (err) {
      console.log("Error encountered while creating using /item-listing/create : "+err);
      return res.status(500).json({
        success: false,
        message: "Internal server error! Contact admin!",
        redirectUrl: "/item-listing/listings"
      });
  }
}

router.get("/", getItemListings);

router.get("/listings", async (req, res) => {
  res.render('listings');
})

router.get("/product", getProductInformation);

router.get("/catalog",  async (req, res) => {
  res.render('product');
});

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


//Mitul: Search&Filter APIs

// router.get("/getUniqueValues", async (req, res) => {
//   const distinctValues = await db.Catalog.findAll({
//     attributes: [[Sequelize.fn('DISTINCT', Sequelize.col('cpu')), 'cpu']]
//   });
//   console.log(distinctValues);
//   res.status(200).send(distinctValues);
// });

router.get("/getUniqueValues", async (req, res) => {
  try {
    // Define the columns you want to get distinct values for
    const columns = ['category', 'cpu', 'gpu', 'ram', 'storage', 'operating_system', 'screen_size', 
    'screen_type', 'screen_resolution', 'front_camera', 'rear_camera'];

    const approval_Status = "Approved";

    // A function to fetch distinct values for a given column
    const getDistinctValues = async (column) => {
      const distinctValues = await db.Catalog.findAll({
        attributes: [[Sequelize.fn('DISTINCT', Sequelize.col(column)), column]],
        where: {
          approval_Status,
          [column]: { [Sequelize.Op.ne]: null }
        },
        order: [[column, 'ASC']]
      });
      return distinctValues.map(item => item[column]);
    };

    // Use Promise.all to fetch all distinct values in parallel
    const results = await Promise.all(columns.map(getDistinctValues));

    // Combine the results into a single object
    const response = columns.reduce((obj, column, index) => {
      obj[column.toUpperCase()] = results[index];
      return obj;
    }, {});

    console.log("RESPONSE ", response);

    // Send the response
    res.status(200).json({
      success: true,
      body: response
    });

    // res.status(200).send(response);
  } catch (error) {
    console.error(error);
    res.status(500).send("An error occurred");
  }
});


router.post("/apply-filter", async (req, res) => {
  console.log("apply-filter-req ", req.body);

  b = await getItemListings();
  console.log(b);
  return res.status(200).send(b);

  // //apply the filters.
  // res.status(200).json({
  //   success: true,
  //   message: req.body
  // });

});

module.exports = router;