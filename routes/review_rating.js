const express = require("express");
const router = express.Router();

const db = require("../models");
const { where } = require("sequelize");
const Catalog = db.Catalog;
const ItemListing = db.ItemListing;
const Review = db.Review;
const User = db.User;
const UserUtil = require("../util/userUtil");

const comment_fetcher = async (item_id, user_id) => {
	const reviewsWithUsernames = await Review.findAll({
		where: { itemId: item_id },
		include: [
			{
				model: User,
				attributes: ["name"],
				required: true,
			},
		],
	});
	const comments = reviewsWithUsernames.map((review) => ({
		username: review.User.name,
		comment: review.comments,
		rating: review.rating,
	}));

	const ind_review = await Review.findOne({
		where: { itemId: item_id, userId: user_id },
	});

	let ind_comment;
	if (ind_review) {
		ind_comment = {
			review_id: ind_review.reviewId,
			comment: ind_review.comments,
			rating: ind_review.rating,
		};
	} else {
		ind_comment = {
			review_id: undefined,
			comment: undefined,
			rating: undefined,
		};
	}
	console.log(ind_comment);
	return { comments: comments, ind_comment: ind_comment };
};
const getReview = async (req, res) => {
	console.log("In Get reivew Item");
	try {
		if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
			// If not authenticated, send a 401 Unauthorized response
			const content = {
				success: false,
				status : 401,
				message:"Authentication failed"
			  }
			return res.status(401).send(content);
		}
		userDetails = await UserUtil.check_email(req.cookies.emailId);
		const item_id = req.body.itemId; //item id of specific item coming from Request

		const comments = await comment_fetcher(item_id, userDetails.userid);
		console.log(comments);
		const content = {
			success : true,
			status : 201,
			body : {comments : comments.comments , ind_comment : comments.ind_comment}
		  }
	  
		res.status(200).render("getreview", content);
	} catch (err) {
		console.log("Error caught in Get method of Review : " + err);
		const content = {
			success: false,
			status : 500,
			message:"Internal Server Error!!"
		  }
		res.status(500).send(content);
	}
};

const addReview = async (req, res) => {
	console.log("In POST reivew Item");
	console.log(req);
	try {
		if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
			// If not authenticated, send a 401 Unauthorized response
			const content = {
				success: false,
				status : 401,
				message:"Authentication failed"
			  }
			return res.status(401).send(content);
		}
		userDetails = await UserUtil.check_email(req.cookies.emailId);
		const item_id = req.body.itemId; //item id of specific item coming from Request
		const ratings = req.body.rating; // rating of specific item coming from Request
		const comment = req.body.comments; // comments of specific item coming from Request

		const old_review = await Review.findOne({
			where: { itemId: item_id, userId: userDetails.userid },
		});

		if (old_review) {
			await Review.destroy({ where: { reviewId: old_review.reviewId } });
		}

		await Review.create({
			userId: userDetails.userid,
			itemId: item_id,
			rating: ratings,
			comments: comment,
		});
		console.log("Data added Successfully in REVIEW");

		//res.send("Data added Successfully in REVIEW");
		const comments = await comment_fetcher(item_id, userDetails.userid);
		const content = {
			success : true,
			status : 201,
			body : {comments : comments.comments , ind_comment : comments.ind_comment}
		  }
	  
		res.status(201).render("getreview", content);
	} catch (err) {
		console.log("Error caught in post method of Review : " + err);
		const content = {
			success: false,
			status : 500,
			message:"Internal Server Error!!"
		  }
		res.status(500).send(content);
	}
};

const deleteReview = async (req, res) => {
	console.log("In delete reivew Item");
	try {
		if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
			// If not authenticated, send a 401 Unauthorized response
			const content = {
				success: false,
				status : 401,
				message:"Authentication failed"
			  }
			return res.status(401).send(content);
		}
		userDetails = await UserUtil.check_email(req.cookies.emailId);
		const review_id = req.params.reviewid; //item id of specific item coming from Request

		const old_review = await Review.findOne({
			where: { reviewId: review_id },
		});

		if (old_review) {
			await Review.destroy({ where: { reviewId: old_review.reviewId } });
			console.log("Deleted review");
			//res.status(204).send("Review deleted successfully");
			const comments = await comment_fetcher(
				old_review.itemId,
				userDetails.userid
			);
			console.log(comments);
			res.status(204).send(); //.render("getreview", {comments : comments.comments , ind_comment : comments.ind_comment});
			return;
		}
		else
		{
			const content = {
				success: false,
				status : 404,
				message:"No reviews found"
			  }
			res.status(404).send(content);
		}
		
		
	} catch (err) {
		console.log("Error caught in delete  method of Review : " + err);
		const content = {
			success: false,
			status : 500,
			message:"Internal Server Error!!"
		  }
		res.status(500).send(content);
	}
};

router.get("/", getReview);
router.post("/", addReview);
router.delete("/:reviewid", deleteReview);

module.exports = router;
