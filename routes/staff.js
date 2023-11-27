const express = require("express");
const router = express.Router();

const mysql = require('mysql2');
// Assuming the encryptionUtil.js file is in the same directory

const db = require('../models');
const { where } = require('sequelize');
const Staff = db.Staff;
const UserUtil = require('../util/userUtil');

           
router.get("/login", async (req, res) => {
	console.log("Successfully in Root :Inssss:sss:: /");
	res.render("staffloginPage");
});

router.post("/login", async (req, res) => {
	const { name, password } = req.body;
	const Staff = db.Staff;
	console.log("IN login");

    try{
		const staff = await Staff.findOne({ where: { name } });

		if (!staff) {
			return res.status(404).json({
				success: false,
				message: "You do not exist in our system. Please Sign up",
			});
		}

	

		if (password !== staff.password) {
			return res.status(401).json({
				success: false,
				message: "You have entered an invalid password, " + staff.name,
			});
		}

		// Calculate the expiration time as the current time + 120 minutes
		const tenMinutes = 1000 * 60 * 120; // 120 minutes in milliseconds
		const expiresAt = new Date(Date.now() + tenMinutes);

		// Set the cookie
		res.cookie("name", staff.name, {
			expires: expiresAt,
			httpOnly: false,
		});

		// Send a JSON response indicating success and possibly a redirect URL.
		return res.status(200).json({
			success: true,
			message: "Welcome " + staff.name + ", Login successful",
			redirectUrl: "/customer_representative/",
		});

    } catch (error) {
		console.error("Error during login:", error);
		return res.status(401).json({
			success: false,
			message: "Login Failed. Please use valid credentials.",
		});
	}
});


module.exports = router;