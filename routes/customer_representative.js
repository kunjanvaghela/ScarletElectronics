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
    res.render('customer_rep_dasboard', {username});
    
});

module.exports = router;


