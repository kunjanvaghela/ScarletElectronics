const express = require("express");
const router = express.Router();

const db = require('../models');
const { where } = require('sequelize');
const EndUserRequest = db.EndUserRequest;
const ItemListing = db.ItemListing;
const UserUtil = require('../util/userUtil');

router.get("/", async (req, res) => {
    console.log('Working');
    userDetails = await UserUtil.check_email(req.cookies.emailId);
    const username = userDetails.name;
    console.log("Username is " + username);
    res.render('customer_rep_dasboard', {username});
    
});

// router.get("/get-existing-listing", async (req, res) => {
//     console.log('Button Working');
//     userDetails = await UserUtil.check_email(req.cookies.emailId);
//     console.log(userDetails.userid);
//     const username = userDetails.name;
//     const item_listing = Catalog.findAll().then(function(Catalog){
        
//         res.render('seller_listing', {Catalog, username});
//         //console.log(Catalog);
        
//       }).catch(function(err){
//         console.log('Oops! something went wrong, : ', err);
//       });
//     //console.log(item_listing);
//     //console.log(typeof(item_listing));
    
// });

module.exports = router;


