const express = require("express");
const router = express.Router();
const send_otp_routes = require("./otp_routes");
const recover_pass_routes = require("./recover_pass_routes");
const axios = require("axios"); // Required for reCAPTCHA verification
const db = require("../models");
const UserUtil = require('../util/userUtil');
const EndUser = db.EndUsers;
const EndUserRequest = db.EndUserRequest;
const jwt = require('jsonwebtoken');
require('dotenv').config()
const { encrypt, decrypt } = require("../util/encryptionUtil");

const multer = require("multer");
const upload = multer();

//###############################
let refreshTokens = []
//###############################


router.get("/Home_Landing", (req, res) => {
	console.log("Successfully in Root :Inssss:sss:: /");
	res.render("Home_Landing");
});


router.get("/home", (req, res) => {
	console.log('Successfully in Landing Page');
	res.render('index_Landing');
});

router.get("/login", (req, res) => {
	console.log("Successfully in Root :Inssss:sss:: /");
	res.render("loginPage");
});

router.get("/logout", (req, res) => {
    console.log("Processing logout");

    // Clearing JWT-related cookies and emailId cookie
    res.clearCookie("accessToken");
    res.clearCookie("refreshToken");
    res.clearCookie("emailId");

    // Optionally, handle the refresh token list if you store them server-side
    const refreshToken = req.cookies.refreshToken;
    refreshTokens = refreshTokens.filter(token => token !== refreshToken);

    // Redirect the user to the login page after logout
    res.redirect("/users/login");
});

router.get("/register", (req, res) => {
	res.render("register");
});

router.get("/cart", (req, res) => {
	const fields = [
		{ name: "email", label: "Email", type: "text" },
		{ name: "password", label: "Password", type: "password" },
		// Add more fields as needed
	];

	res.render("cartPage", { fields });
});

router.get("/checkout", (req, res) => {
	const itemsArray = [
		{ item: "item1", qty: 2, cost_qty: 10, cost_item: 10 },
		{ item: "item2", qty: 1, cost_qty: 5, cost_item: 10 },
		// Add more items as needed
	];

	res.render("checkoutPage", { itemsArray });
});

router.get("/forgot-password", (req, res, next) => {
	res.render("forgot-password");
});

router.post("/registerUser", upload.none(), async (req, res) => {
	const recaptchaResponse = req.body["g-recaptcha-response"];
	console.log("IN REGISTER USER NOW WILL PRINT REQ");
	//console.log(req)
	// Check if CAPTCHA response is present
	if (!recaptchaResponse) {
		return res
			.status(400)
			.json({ success: false, message: "Please complete the CAPTCHA" });
	}

	try {
		// Verify reCAPTCHA
		const verificationURL = `https://www.google.com/recaptcha/api/siteverify?secret=6Lffbu8oAAAAAHnr8NxZtRoP9-f7367MM9S_MjtN&response=${recaptchaResponse}`;
		const verificationResponse = await axios.post(verificationURL);

		if (!verificationResponse.data.success) {
			return res.status(400).json({
				success: false,
				message:
					"CAPTCHA verification Failed/ Expired. Reload and Try again",
			});
		}

		const userData = req.body;
		const User = db.User;
		console.log("USERDATA BEFORE INSERT", userData);

		await User.create(userData).then((user) => {
			userData.userId = user.userid;
			console.log("User Inserted, now have to insert EndUser");
			console.log(userData);
			EndUser.create(userData);
		});

		return res.status(200).json({
			success: true,
			message: "Welcome " + User.name + ",  Registration Successful",
		});
	} catch (error) {
		console.error("Error occurred:", error);
		res.status(409).json({
			success: false,
			message:
				"Email already exists in the system, Please Login or use Forget Password Option.",
		});
	}
});

router.post("/login", async (req, res) => {
	const { emailId, password } = req.body;
	const User = db.User;
	console.log("IN login");

	const recaptchaResponse = req.body["g-recaptcha-response"];

	// Check if CAPTCHA response is present
	if (!recaptchaResponse) {
		return res
			.status(400)
			.json({ success: false, message: "Please complete the CAPTCHA." });
	}

	try {
		console.log("Try1");
		// Verify reCAPTCHA
		const verificationURL = `https://www.google.com/recaptcha/api/siteverify?secret=6Lffbu8oAAAAAHnr8NxZtRoP9-f7367MM9S_MjtN&response=${recaptchaResponse}`;
		const verificationResponse = await axios.post(verificationURL);

		console.log("Try2");
		if (!verificationResponse.data.success) {
			return res.status(400).json({
				success: false,
				message:
					"CAPTCHA verification Failed/ Expired. Reload and Try again",
			});
		}

		const user = await User.findOne({ where: { emailId } });

		if (!user) {
			return res.status(404).json({
				success: false,
				message: "You do not exist in our system. Please Sign up",
			});
		}

		const decryptedPassword = decrypt(user.encrypted_password);

		if (password !== decryptedPassword) {
			return res.status(401).json({
				success: false,
				message: "You have entered an invalid password, " + user.name,
			});
		}

		console.log("Username and password verified");

		//JWT TOKEN IMPLEMENTATION:
		const tokenPackage = {userid: user.userid};
		const accessToken = UserUtil.generateAccessToken(tokenPackage)

		const refreshToken = jwt.sign(tokenPackage, process.env.REFRESH_TOKEN_SECRET)
		refreshTokens.push(refreshToken)
		
		const tenMinutes = 1000 * 60 * 120; // 120 minutes in milliseconds
		const expiresAt = new Date(Date.now() + tenMinutes);
		res.cookie("emailId", user.emailId, {
			expires: expiresAt,
			httpOnly: false,
		});
		res.cookie("accessToken", accessToken, {
			httpOnly: false,
		});
		res.cookie("refreshToken", refreshToken, {
			httpOnly: false,
		});

		return res.status(200).json({
			success: true,
			message: "Welcome " + user.name + ", Login successful",
			// accessToken: accessToken,
			// refreshToken: refreshToken,
			redirectUrl: "/item-listing"
		});
	} catch (error) {
		console.error("Error during login:", error);
		return res.status(401).json({
			success: false,
			message: "Login Failed. Please use valid credentials.",
		});
	}
});

//###############################




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
		const emailId = req.cookies.emailId;
		var userDetails = await db.User.findOne({ where: { emailId } });
		const userId = userDetails.dataValues.userid;
		db.User.update(
			{
				name: req.body.name,
			},
			{ where: { userid: userId } }
		);

		db.EndUsers.update(
			{
				phone_nr: req.body.phone,
				address_line1: req.body.address_line1,
				address_line2: req.body.address_line2,
				address_city: req.body.address_city,
				address_state_code: req.body.address_state_code,
				address_zipcode: req.body.address_zipcode,
			},
			{ where: { userid: userId } }
		);
		res.redirect("/users/");
	} else {
		res.redirect("login");
	}
});

router.get("/support", (req, res) => {
	console.log("Successfully in Root :Inssss:sss:: /");
	res.render("supportpage");
});

router.get("/support/newrequest", async (req, res) => {
	
    // const userDetails = await UserUtil.check_email(req.cookies.emailId);
    // const username = userDetails.name;
    // console.log('username : ',  username);
    res.render("newrequest");
    
});
router.get("/support/oldrequests", async (req, res) => {
    // const userDetails = await UserUtil.check_email(req.cookies.emailId);
    // const username = userDetails.name;
    // console.log('username : ',  username);
    res.render("oldrequests");
    
});



router.post("/support/newrequest", async (req, res) => {
	const { name, emailId } = req.body;
	const User = db.User;
	const userData = req.body

	const user = await User.findOne({ where: { emailId } });
	if (!user) {
		return res.status(404).json({
			success: false,
			message: "You do not exist in our system. Please Sign up",
		});
	}


		// Calculate the expiration time as the current time + 120 minutes
	const tenMinutes = 1000 * 60 * 120; // 120 minutes in milliseconds
	const expiresAt = new Date(Date.now() + tenMinutes);

		// Set the cookie
	res.cookie("emailId", user.emailId, {
		expires: expiresAt,
		httpOnly: false,
	});


    userData.userId = user.userid;
	userData.current_status = 'A'
    console.log("User Inserted, now have to insert staffUser");
    console.log(userData);
    EndUserRequest.create(userData);
    
        
    res.redirect('/users/support'); 
	
});
			
	

module.exports = router;
