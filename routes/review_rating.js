const express = require("express");
const router = express.Router();

const db = require('../models');
const { where } = require('sequelize');
const Catalog = db.Catalog;
const ItemListing = db.ItemListing;
const Review = db.Review;
const User = db.User;
const UserUtil = require('../util/userUtil');

const comment_fetcher = async(item_id) => {
    const reviewsWithUsernames = await Review.findAll({
      where: { itemId: item_id },
      include: [
        {
          model: User,
          attributes: ['name'],
          required: true, 
        },
      ],
    });
    const comments = reviewsWithUsernames.map(review => ({
      username: review.User.name,
      comment: review.comments,
      rating: review.rating,
    }));

    return comments;
}

router.get("/", async(req, res) => {
    console.log("In Get reivew Item");
    userDetails = await UserUtil.check_email(req.cookies.emailId);
    const item_id = req.body.itemId //item id of specific item coming from Request  
    
    const comments = await comment_fetcher(item_id)
    console.log(comments);
    res.status(200).render("getreview", {comments : comments});



});

router.post("/", async(req, res) => {
    console.log("In POST reivew Item");
    console.log(req);
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

        //res.send("Data added Successfully in REVIEW");
        const comments = await comment_fetcher(item_id);
        res.status(201).render("getreview", {comments : comments});

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
        res.status(204).send("Review deleted successfully");
        return;
    }
    res.status(404).send("No review found for this item for the given user");
    
});

module.exports = router;
