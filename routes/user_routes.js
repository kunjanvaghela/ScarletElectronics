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

const logoutUser = (req, res) => {
    if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
        return res.status(401).send('Authentication failed');
    }
    console.log("Processing logout");

    res.clearCookie("accessToken");
    res.clearCookie("refreshToken");
    res.clearCookie("emailId");

    const refreshToken = req.cookies.refreshToken;
    refreshTokens = refreshTokens.filter(token => token !== refreshToken);

    res.redirect("/users/login");
};


router.get("/register", (req, res) => {
	res.render("register");
});

// router.get("/cart", (req, res) => {
// 	if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
// 		// If not authenticated, send a 401 Unauthorized response
// 		return res.status(401).send('Authentication failed');
// 	}
// 	const fields = [
// 		{ name: "email", label: "Email", type: "text" },
// 		{ name: "password", label: "Password", type: "password" },
// 		// Add more fields as needed
// 	];

// 	res.render("cartPage", { fields });
// });

// router.get("/checkout", (req, res) => {
// 	if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
// 		// If not authenticated, send a 401 Unauthorized response
// 		return res.status(401).send('Authentication failed');
// 	}
// 	const itemsArray = [
// 		{ item: "item1", qty: 2, cost_qty: 10, cost_item: 10 },
// 		{ item: "item2", qty: 1, cost_qty: 5, cost_item: 10 },
// 		// Add more items as needed
// 	];

// 	res.render("checkoutPage", { itemsArray });
// });

router.get("/forgot-password", (req, res, next) => {
	res.render("forgot-password");
});

const registerUser = async (req, res) => {
    const recaptchaResponse = req.body["g-recaptcha-response"];
    console.log("IN REGISTER USER NOW WILL PRINT REQ");

    if (!recaptchaResponse) {
        return res
            .status(400)
            .json({ success: false, message: "Please complete the CAPTCHA" });
    }

    try {
        const verificationURL = `https://www.google.com/recaptcha/api/siteverify?secret=6Lffbu8oAAAAAHnr8NxZtRoP9-f7367MM9S_MjtN&response=${recaptchaResponse}`;
        const verificationResponse = await axios.post(verificationURL);

        if (!verificationResponse.data.success) {
            return res.status(400).json({
                success: false,
                message: "CAPTCHA verification Failed/ Expired. Reload and Try again",
            });
        }

        const userData = req.body;
        const User = db.User;
        console.log("USERDATA BEFORE INSERT", userData);

        await User.create(userData).then((user) => {
            userData.userId = user.userid;
            console.log("User Inserted, now have to insert EndUser");
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
            message: "Email already exists in the system, Please Login or use Forget Password Option.",
        });
    }
};

const loginUser = async (req, res) => {
    const { emailId, password } = req.body;
    const User = db.User;
    console.log("IN login");

    const recaptchaResponse = req.body["g-recaptcha-response"];
    if (!recaptchaResponse) {
        return res
            .status(400)
            .json({ success: false, message: "Please complete the CAPTCHA." });
    }

    try {
        const verificationURL = `https://www.google.com/recaptcha/api/siteverify?secret=6Lffbu8oAAAAAHnr8NxZtRoP9-f7367MM9S_MjtN&response=${recaptchaResponse}`;
        const verificationResponse = await axios.post(verificationURL);

        if (!verificationResponse.data.success) {
            return res.status(400).json({
                success: false,
                message: "CAPTCHA verification Failed/ Expired. Reload and Try again",
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

        // JWT TOKEN IMPLEMENTATION
        const tokenPackage = { userId: user.userid, emailId: user.emailId };
        const accessToken = UserUtil.generateAccessToken(tokenPackage);
        const refreshToken = jwt.sign(tokenPackage, process.env.REFRESH_TOKEN_SECRET);
        refreshTokens.push(refreshToken);

        res.cookie("accessToken", accessToken, {
            httpOnly: false,
        });

        const object = UserUtil.retrieveTokenPayload(accessToken);
        console.log("ACCESSING USERID FROM TOKENPAAYLOAD:", object.userId);

        return res.status(200).json({
            success: true,
            message: "Welcome " + user.name + ", Login successful",
            redirectUrl: "/item-listing"
        });
    } catch (error) {
        console.error("Error during login:", error);
        return res.status(401).json({
            success: false,
            message: "Login Failed. Please use valid credentials.",
        });
    }
};


//###############################

router.use("/send-otp", send_otp_routes);
router.use("/recover-password", recover_pass_routes);

router.get("/", async (req, res) => {
	if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
		// If not authenticated, send a 401 Unauthorized response
		return res.status(401).send('Authentication failed');
	}
	const payload = UserUtil.retrieveTokenPayload(req.cookies.accessToken);
	console.log("ACCESSING USERID FROM TOKENPAAYLOAD:", payload.userId);
	console.log("ACCESSING emailId FROM TOKENPAAYLOAD:", payload.emailId);
	if (payload.emailId) {
		const emailId = payload.emailId;
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

		return res.status(200).json({
			success: true,
			status: 200,
			body: user
		});

		// res.render("userProfile", { user: user });
	} else {

		return res.status(401).json({
			success: false,
			status: 401,
			message: "Invalid cookie",
			redirectUrl: "/users/login"
		});

		// res.redirect("login");
	}
});

const modifyUser = async (req, res) => {
    if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
        return res.status(401).send('Authentication failed');
    }

    const payload = UserUtil.retrieveTokenPayload(req.cookies.accessToken);
    console.log("ACCESSING USERID FROM TOKENPAAYLOAD:", payload.userId);
    console.log("ACCESSING emailId FROM TOKENPAAYLOAD:", payload.emailId);

    if (payload.emailId) {
        const emailId = payload.emailId;
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
};

const postModifyUser = async (req, res) => {
    if (!UserUtil.authenticateToken(req.cookies.accessToken)) {
        return res.status(401).send('Authentication failed');
    }

    const payload = UserUtil.retrieveTokenPayload(req.cookies.accessToken);
    console.log("ACCESSING USERID FROM TOKENPAAYLOAD:", payload.userId);
    console.log("ACCESSING emailId FROM TOKENPAAYLOAD:", payload.emailId);

    if (payload.emailId) {
        const emailId = payload.emailId;
        var userDetails = await db.User.findOne({ where: { emailId } });
        const userId = userDetails.dataValues.userid;

        await db.User.update(
            {
                name: req.body.name,
            },
            { where: { userid: userId } }
        );

        await db.EndUsers.update(
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
        return res.status(200).json({
			success: true,
			status: 200,
			message: "Updated successfully",
			redirectUrl: "/users/profile"
		});
    } else {
        return res.status(401).json({
			success: false,
			status: 401,
			message: "Invalid cookie",
			redirectUrl: "/users/login"
		});
    }
};

const getsupport = async (req, res) => {
	console.log("Successfully in Root :Inssss:sss:: /");
	res.render("supportpage");
};

const getSupportnewrequest =  async (req, res) => {
	
    // const userDetails = await UserUtil.check_email(req.cookies.emailId);
    // const username = userDetails.name;
    // console.log('username : ',  username);
    res.render("newrequest");
    
};
const getSupportoldrequests = async (req, res) => {
    // const userDetails = await UserUtil.check_email(req.cookies.emailId);
    // const username = userDetails.name;
    // console.log('username : ',  username);
    res.render("oldrequests");
    
};



const postSupportnewrequest = async (req, res) => {
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
	
};

router.get("/support", getsupport);
router.get("/support/newrequest", getSupportnewrequest);
router.get("/support/oldrequests", getSupportoldrequests);
router.post("/support/newrequest", postSupportnewrequest);


router.post("/registerUser", upload.none(), registerUser);
router.post("/login", loginUser);
router.get("/modify-user", modifyUser);
router.post("/modify-user", postModifyUser);
router.get("/logout", logoutUser);

module.exports = router;
