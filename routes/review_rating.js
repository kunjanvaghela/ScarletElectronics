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
    const ratings = req.body.rating // rating of specific item coming from Request
    const comment = req.body.comments // comments of specific item coming from Request

    const old_review = await Review.findOne({where : {itemId : item_id , userId: userDetails.userid}});

    if(old_review)
    {
        await Review.destroy({where : {reviewId : old_review.reviewId}});
    }
    try
    {
        await Review.create({userId : userDetails.userid, itemId : item_id, rating : ratings , comments : comment});
        console.log("Data added Successfully in REVIEW");

        res.send("Data added Successfully in REVIEW");

    }
    catch(err)
    {
        console.log("Error caught in post method of Review : " + err);

    }
});

router.delete("/:reviewid", async(req, res) => {
    console.log("In delete reivew Item");
    userDetails = await UserUtil.check_email(req.cookies.emailId);
    const review_id = req.params.reviewid; //item id of specific item coming from Request
    
    const old_review = await Review.findOne({where : {reviewId : review_id}});

    if(old_review)
    {
        await Review.destroy({where : {reviewId : old_review.reviewId}});
        console.log("Deleted review");
        res.send("Review deleted successfully");
        return;
    }
    res.send("No review found for this item for the given user");
    
});

module.exports = router;
