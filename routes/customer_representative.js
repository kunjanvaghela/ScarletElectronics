const express = require("express");
const router = express.Router();

const db = require('../models');
const { where } = require('sequelize');
const EndUserRequest = db.EndUserRequest;
const User = db.User;

const UserUtil = require('../util/userUtil');

router.get("/", async (req, res) => {
    console.log('Working');
    userDetails = await UserUtil.check_email(req.cookies.emailId);
    console.log(userDetails);
    const username = userDetails.name;
    const custRepId = userDetails.userid;
    console.log("Username is " + username);

    EndUserRequest.findAll({
        where: {
            customer_rep: custRepId
        }
      }).then((requests) => {
        const serializedRequests = requests.map((request) => {
          return {
            requestId: request.requestId,
            userId: request.userId,
            listingId: request.listingId,
            updateDescription: request.update_description,
            createdOn: request.created_on,
            currentStatus: request.current_status,
            customerRep: username,
            updatedOn: request.updated_on
          };
        });
    
        // Send the serialized data as a response
        res.render('customer_rep_dasboard', {serializedRequests, username});
        // res.render('seller_listing', {serializedListings})
      }).catch((error) => {
        console.error('Error retrieving data:', error);
        res.status(500).send('Internal server error');
      });
  
});

router.get("/show-all-request", async (req, res) => {
    console.log('Button Working');
    userDetails = await UserUtil.check_email(req.cookies.emailId);
    console.log(userDetails.userid);
    const username = userDetails.name;

    EndUserRequest.findAll({
    
    }).then((requests) => {
      const serializedRequests = requests.map((request) => {
        return {
          requestId: request.requestId,
          userId: request.userId,
          listingId: request.listingId,
          updateDescription: request.update_description,
          createdOn: request.created_on,
          currentStatus: request.current_status,
          customerRep: username,
          updatedOn: request.updated_on
        };
      });
    //const all_requests = EndUserRequest.findAll().then(function(serializedRequests){
        
        res.render('all_requests', {serializedRequests, username});
        
        
      }).catch(function(err){
        console.log('Oops! something went wrong, : ', err);
      });
    
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


