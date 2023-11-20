const express = require("express");
const router = express.Router();

const db = require('../models');
const { where } = require('sequelize');
const Catalog = db.Catalog;
const ItemListing = db.ItemListing;
const Review = db.Review;
const UserUtil = require('../util/userUtil');

router.get("/", async(req, res) => {
    console.log("In Get reivew Item");
    userDetails = await UserUtil.check_email(req.cookies.emailId);
    const item_id = req.body.itemId //item id of specific item coming from Request
    
    const reviews = await Review.findAll({where : {itemId : item_id}});

    console.log(reviews);

    res.send(reviews);



});

router.post("/", async(req, res) => {
    console.log("In POST reivew Item");
    userDetails = await UserUtil.check_email(req.cookies.emailId);
    const item_id = req.body.itemId //item id of specific item coming from Request
    
    const reviews = await Review.findAll({where : {itemId : item_id}});

    console.log(reviews);

    res.send(reviews);



});

module.exports = router;
