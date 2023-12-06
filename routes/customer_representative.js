const express = require("express");
const router = express.Router();

const db = require('../models');
const { where } = require('sequelize');
const EndUserRequest = db.EndUserRequest;
const ItemListing = db.ItemListing; //newcode
const Messages = db.Messages;
const User = db.User;

const UserUtil = require('../util/userUtil');

router.get("/", async (req, res) => {
  userDetails = await UserUtil.check_email(req.cookies.emailId);
  //console.log(userDetails);
  const username = userDetails.name;
  const custRepId = userDetails.userid;
  console.log("Username is " + username);
  res.render('all_requests', {username});
});

router.post("/get-claimed-requests", async (req, res) => {
  console.log('Working');
  userDetails = await UserUtil.check_email(req.cookies.emailId);
  //console.log(userDetails);
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
      //res.render('customer_rep_dasboard', {serializedRequests, username});
      return res.status(200).json({
        success: true,
        message: "Requests fetched from database",
        serializedRequests: serializedRequests
        
      });
      // res.render('seller_listing', {serializedListings})
    }).catch((error) => {
      console.error('Error retrieving data:', error);
      res.status(500).send('Internal server error');
    });

});

const getshowallrequest = async (req, res) => {
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
        customerRep: request.customer_rep,
        updatedOn: request.updated_on
      };
    });
  //const all_requests = EndUserRequest.findAll().then(function(serializedRequests){
      
      //res.render('all_requests', {serializedRequests, username});
        return res.status(200).json({
        success: true,
        message: "Request assigned to you",
        serializedRequests: serializedRequests
        
      });
      
      
    }).catch(function(err){
      console.log('Oops! something went wrong, : ', err);
    });
  
};
router.post("/show-all-request", getshowallrequest);

// router.get("/show-all-request", async (req, res) => {
//     console.log('Button Working');
//     userDetails = await UserUtil.check_email(req.cookies.emailId);
//     console.log(userDetails.userid);
//     const username = userDetails.name;

//     EndUserRequest.findAll({
    
//     }).then((requests) => {
//       const serializedRequests = requests.map((request) => {
//         return {
//           requestId: request.requestId,
//           userId: request.userId,
//           listingId: request.listingId,
//           updateDescription: request.update_description,
//           createdOn: request.created_on,
//           currentStatus: request.current_status,
//           customerRep: username,
//           updatedOn: request.updated_on
//         };
//       });
//     //const all_requests = EndUserRequest.findAll().then(function(serializedRequests){
        
//         res.render('all_requests', {serializedRequests, username});
        
        
//       }).catch(function(err){
//         console.log('Oops! something went wrong, : ', err);
//       });
    
// });

router.post("/claim-request",async (req, res) => {
    
    receivedRequestId = req.body.reqID;
    console.log("The requestID is : ", receivedRequestId);
    //console.log("!!!!!!!!!!!!!hsjabfkaskhf: ", receivedRequestId);
    userDetails = await UserUtil.check_email(req.cookies.emailId);
    //console.log(userDetails.userid);
    const username = userDetails.name;
    EndUserRequest.findOne({where: {requestId: receivedRequestId}}).then((table) => {
      table.customer_rep = userDetails.userid
      
      return table.save();
    }).then(() => {
       
      // Send the serialized data as a response
      //res.redirect('/customer_representative/show-all-request');
      return res.status(200).json({
        success: true,
        message: "Request assigned to you",
        
        redirectUrl: "/customer_representative/show-all-request"
      });
      // res.render('listings', { serializedListings, username });
      
    }).catch((error) => {
      console.error('Error retrieving data:', error);
      res.status(500).send('Internal server error');
    });
    // EndUserRequest.update({customerRep: userDetails.userid},{where: {requestId: receivedRequestId}}).then(() => {
       
    //   // Send the serialized data as a response
    //   res.redirect('/customer_representative/show-all-request');
      
    // }).catch((error) => {
    //   console.error('Error retrieving data:', error);
    //   res.status(500).send('Internal server error');
    // });
    
});

//Renders threads page
router.get("/thread", async (req, res) => {
  userDetails = await UserUtil.check_email(req.cookies.emailId);
    //console.log(userDetails.userid);
    
  const username = userDetails.name;
  const reqId = req.query.reqId;
  //console.log(req);
  console.log(reqId);

  res.render("threads",{ username, reqId });
});

//Function to get messeges 
const getAllMesseges = async (req, res) => {

  userDetails = await UserUtil.check_email(req.cookies.emailId);
  console.log(userDetails.userid);
  const username = userDetails.name;

  const reqId = req.body.reqId;
  console.log("RequestId received = ", reqId);

  Messages.findAll({
    where: {
      requestId: reqId
  }
  
  }).then((messages) => {
    const serializedMessages = messages.map((getMessage) => {
      return {
        messageId: getMessage.messageId,
        requestId: getMessage.requestId,
        userId: getMessage.userId,
        customerRep: getMessage.customer_rep,
        listingId: getMessage.listingId,
        updateDescription: getMessage.update_description,
        createdOn: getMessage.created_on
      };
    });
  //const all_requests = EndUserRequest.findAll().then(function(serializedRequests){
      
      //res.render('all_requests', {serializedRequests, username});
        return res.status(200).json({
        success: true,
        message: "Request assigned to you",
        serializedMessages: serializedMessages
        
      });
      
      
    }).catch(function(err){
      console.log('Oops! something went wrong, : ', err);
    });
  



};
router.post("/show-all-messeges", getAllMesseges);


//newcode
router.get("/rep_listings", async (req, res) => {

  try {
    userDetails = await UserUtil.check_email(req.cookies.emailId);
    console.log(userDetails.userid);
    const username = userDetails.name;
    const rep_listings = await ItemListing.findAll();
    res.render('rep_listings', { rep_listings, username });
  } catch (error) {
    console.error('Error fetching listings:', error);
    res.status(500).send('Internal Server Error');
  }
});

// Route to handle deletion of a listing
router.post("/rep_listings/delete/:listingId", async (req, res) => {

  const listingId = req.params.listingId;
  try {
    userDetails = await UserUtil.check_email(req.cookies.emailId);
    console.log(userDetails.userid);
    const username = userDetails.name;
    await ItemListing.destroy({ where: { listingId } });
    res.redirect('/customer_representative/rep_listings');
  } catch (error) {
    console.error('Error deleting listing:', error);
    res.status(500).send('Internal Server Error');
  }
});

// Route to render the modification form
router.get("/rep_listings/modify/:listingId", async (req, res) => {

  const listingId = req.params.listingId;
  try {
    userDetails = await UserUtil.check_email(req.cookies.emailId);
    console.log(userDetails.userid);
    const username = userDetails.name;
    const listing = await ItemListing.findByPk(listingId);
    res.render('modify_listing', { listing, username });
  } catch (error) {
    console.error('Error fetching listing for modification:', error);
    res.status(500).send('Internal Server Error');
  }
});

// Route to handle the form submission for modification
router.post("/rep_listings/modify/:listingId", async (req, res) => {

  const listingId = req.params.listingId;
  try {
    userDetails = await UserUtil.check_email(req.cookies.emailId);
    console.log(userDetails.userid);
    const username = userDetails.name;
    // Update the ItemListing with the new values from the form
    await ItemListing.update(req.body, { where: { listingId } });

    res.redirect('/customer_representative/rep_listings');
  } catch (error) {
    console.error('Error modifying listing:', error);
    res.status(500).send('Internal Server Error');
  }
});
module.exports = router;


