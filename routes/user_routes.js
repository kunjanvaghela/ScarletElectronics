const express = require("express");
const url = require("url");
const router = express.Router();
const send_otp_routes = require("./otp_routes");
const recover_pass_routes = require("./recover_pass_routes");
const mysql = require("mysql2");
const { encrypt, decrypt } = require("../util/encryptionUtil"); // Assuming the encryptionUtil.js file is in the same directory

const db = require("../models");
const { where } = require("sequelize");
const EndUser = db.EndUsers;
const User = db.User;
const OTP = db.OTP;

router.get("/Home_Landing", (req, res) => {
	console.log("Successfully in Root :Inssss:sss:: /");
	res.render("Home_Landing");
});

router.get("/login", (req, res) => {
	console.log("Successfully in Root :Inssss:sss:: /");
	res.render("loginPage");
});

router.get("/register", (req, res) => {
	res.render("register");
});

router.get("/forgot-password", (req, res, next) => {
	res.render("forgot-password");
});

router.post("/registerUser", async (req, res) => {
	// Get data from request
	const userData = req.body;
	const User = db.User;
	// console.log(userData['emailId']);

	try {
		// const user = await User.create(userData);
		await User.create(userData).then((user) => {
			userData.userId = user.userid;
			console.log("User Inserted, now have to insert EndUser");
			console.log(userData);
			EndUser.create(userData);
		});

		res.redirect("Home_Landing"); // Redirect to login or any other page
	} catch (error) {
		// Handle the error response
		console.error("Error occurred:", error);
		res.status(409).render("loginPage", {
			message:
				"Email alredy exists in the system, Please Login or use Forget Password Option.",
		});
		// res.status(500).send('Error occurred');
	}
});

router.post("/login", async (req, res) => {
	// Get data from request
	const { emailId, password } = req.body;

	const User = db.User;

	try {
		const user = await User.findOne({ where: { emailId } });

		if (!user) {
			return res.status(404).render("loginPage", {
				message: "You do not exists in our system. Please Sign up",
			});
		}

		const decryptedPassword = decrypt(user.encrypted_password);

		if (password !== decryptedPassword) {
			return res.status(401).render("loginPage", {
				message: "Wrong Password. Please try again!",
			});
		}

		// Calculate the expiration time as the current time + 10 minutes
		const tenMinutes = 1000 * 60 * 10; // 10 minutes in milliseconds
		const expiresAt = new Date(Date.now() + tenMinutes);

		// Handle the response after success
		res.cookie("emailId", user.emailId, {
			expires: expiresAt,
			httpOnly: true,
		});

		// return res.status(200).json({ message: 'Welcome '+user.name+',  Login successful' });
		// return res.status(201).redirect('/users/Home_Landing');  // Manad's redirection
		return res.status(200).render("seller_listing");
	} catch (error) {
		console.error("Error during login:", error);
		return res.status(401).render("loginPage", {
			message: "Login Failed Please use valid Credentials",
		});
	}
});

router.use("/send-otp", send_otp_routes);
router.use("/recover-password", recover_pass_routes);

router.get("/", async (req, res) => {
	if (req.cookies.emailId) {
		const emailId = req.cookies.emailId;
		const userDetails = await db.User.findOne({ where: { emailId } });
		const userId = userDetails.dataValues.userid;
		const endUserDetails = await db.EndUsers.findOne({ where: { userId } });
		const user = {
			name: userDetails.name,
			emailId: userDetails.emailId,
			phone: endUserDetails.phone_nr,
			address1: endUserDetails.address_line1,
			address2: endUserDetails.address_line2,
			city: endUserDetails.address_city,
			state: endUserDetails.address_state_code,
			zipcode: endUserDetails.address_zipcode,
		};
		res.render("userProfile", { user: user });
	} else {
		res.redirect("login");
	}
});

router.get("/modify-user", async (req, res) => {
	if (req.cookies.emailId) {
		console.log("#########################");
		console.log(req.query);
		const emailId = req.cookies.emailId;
		const userDetails = await db.User.findOne({ where: { emailId } });
		const userId = userDetails.dataValues.userid;
		const endUserDetails = await db.EndUsers.findOne({ where: { userId } });
		const user = {
			name: userDetails.name,
			emailId: userDetails.emailId,
			phone: endUserDetails.phone_nr,
			address1: endUserDetails.address_line1,
			address2: endUserDetails.address_line2,
			city: endUserDetails.address_city,
			state: endUserDetails.address_state_code,
			zipcode: endUserDetails.address_zipcode,
		};
		res.render("editProfile", { user: user });
	} else {
		res.redirect("login");
	}
});

router.post("/modify-user", async (req, res) => {
	if (req.cookies.emailId) {
		const newName = req.body.name;
		const emailId = req.cookies.emailId;
		var userDetails = await db.User.findOne({ where: { emailId } });
		const userId = userDetails.dataValues.userid;
		db.User.update(
			{
				name: newName,
			},
			{ where: { userid: userId } }
		);

		// db.EndUsers.update(
		// 	{
		// 		phone: endUserDetails.phone_nr,
		// 		address1: endUserDetails.address_line1,
		// 		address2: endUserDetails.address_line2,
		// 		city: endUserDetails.address_city,
		// 		zipcode: endUserDetails.address_zipcode,
		// 	},
		// 	{ where: { userId } }
		// );
		var userDetails = await db.User.findOne({ where: { userId } });
		const endUserDetails = await db.EndUsers.findOne({ where: { userId } });
		const user = {
			name: userDetails.name,
			emailId: userDetails.emailId,
			phone: endUserDetails.phone_nr,
			address1: endUserDetails.address_line1,
			address2: endUserDetails.address_line2,
			city: endUserDetails.address_city,
			zipcode: endUserDetails.address_zipcode,
		};
		res.render("userProfile", { user: user });
	} else {
		res.redirect("login");
	}
});

module.exports = router;
