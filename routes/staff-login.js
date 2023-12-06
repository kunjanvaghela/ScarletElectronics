const express = require("express");
const router = express.Router();
const mysql = require('mysql2');
const db = require('../models');
const { where } = require('sequelize');
const UserUtil = require('../util/userUtil');
const { encrypt, decrypt } = require("../util/encryptionUtil");

const User = db.User;
const Staff = db.Staff;

// GET route to render the login page
const getstafflogin = async (req, res) => {
  res.render("staffloginPage");
};

// POST route to handle login
const poststafflogin = async (req, res) => {
  const { emailId, password } = req.body;

  try {
    // Check if the emailId exists in the users table
    const user = await User.findOne({ where: { emailId } });

    if (!user) {
      return res.status(404).json({
        success: false,
        message: "You do not exist in our system.",
      });
    }

    // Check if the userId exists in the staff table
    const staffUser = await Staff.findOne({ where: { userId: user.userId } });

    if (!staffUser) {
      return res.status(401).json({
        success: false,
        message: "You are not authorized to log in as a staff member.",
      });
    }

    // Check if the provided password matches the hashed password in the database
	const decryptedPassword = decrypt(user.encrypted_password);

	if (password !== decryptedPassword) {
		return res.status(401).json({
			success: false,
			message: "You have entered an invalid password, " + user.name,
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

    // Send a JSON response indicating success and possibly a redirect URL.
    return res.status(200).json({
      success: true,
      message: "Welcome " + user.name + ", Login successful",
    });

  } catch (error) {
    console.error("Error during login:", error);
    return res.status(401).json({
      success: false,
      message: "Login Failed. Please use valid credentials.",
    });
  }
};

router.get("/login", getstafflogin);
router.post("/login", poststafflogin);
module.exports = router;
