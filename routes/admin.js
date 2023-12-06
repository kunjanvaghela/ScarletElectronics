const express = require("express");
const router = express.Router();

const mysql = require('mysql2');
// Assuming the encryptionUtil.js file is in the same directory

const db = require('../models');
const { where } = require('sequelize');
const Staff = db.Staff;
const User = db.User;
const UserUtil = require('../util/userUtil');
const { encrypt, decrypt } = require("../util/encryptionUtil");




const getdashboard = async (req, res) => {
    console.log('Successfully in /admin/dashboard');
    const userDetails = await UserUtil.check_email(req.cookies.emailId);
    const username = userDetails.name;
    console.log('username : ',  username);
    res.render('admindashboard', { username });
    
};

const getCustomerrep = async (req, res) => {
    const userDetails = await UserUtil.check_email(req.cookies.emailId);
    const username = userDetails.name;
    console.log('username : ',  username);
    res.render('CreateCustomerRep', { username });
    
};

// router.post('/insert-customer-rep', async (req, res) => {

//     //Cookie-Presence check. TODO can be used further to validate user.
//     console.log(req.cookies);
//     console.log('Receievd data:', req.body)
    
//     // Get data from request
//     const userData = req.body;
//     const User = db.User;
//     console.log(userData);

//     try {
        
//         await User.create(userData).then((user) => {
//             userData.userId = user.userid;
//             console.log("User Inserted, now have to insert staffUser");
//             console.log(userData);
//             Staff.create(userData);
//         });
//         // return res.status(200).json({
// 		// 	success: true,
// 		// 	// message: "Welcome " + User.name + ",  Registration Successful",
// 		// });
//         // Handle the response after success
//          res.redirect('/admin/dashboard');  // Redirect to login or any other page
//     } catch (error) {
//         // Handle the error response
//         console.error('Error occurred:', error);
//         res.status(500).send('Error occurred');
//     }
// });

const postinsertCustomerrep =  async (req, res) => {
    // Cookie-Presence check. TODO can be used further to validate user.
    console.log(req.cookies);
    console.log('Received data:', req.body);

    // Get data from request
    const userData = req.body;
    const User = db.User;
    console.log(userData);

    try {
        await User.create(userData).then((user) => {
            userData.userId = user.userid;
            console.log("User Inserted, now have to insert staffUser");
            console.log(userData);
            Staff.create(userData);
        });

        // Instead of redirecting, send a JSON response
        res.status(200).json({
            success: true,
            // redirectTo: '/admin/dashboard', // Include the desired redirection path
        });
    } catch (error) {
        console.error('Error occurred:', error);
        res.status(500).json({
            success: false,
            message: 'Error occurred',
        });
    }
};


// GET route to render the login page
const getAdminlogin = async (req, res) => {
  res.render("adminloginpage");
};


const postAdminlogin = async (req, res) => {
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
  
      // Log the designation to check if it's correct
      console.log("Designation:", staffUser.designation);
  
      // Check if the staff user has the designation "admin"
      if (staffUser.designation !== 'admin') {
        return res.status(401).json({
          success: false,
          message: "You are not authorized to log in as an admin.",
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
  
  

router.get("/dashboard", getdashboard);
router.get("/customer-rep", getCustomerrep);
router.post('/insert-customer-rep', postinsertCustomerrep);
router.get("/login", getAdminlogin);
router.post("/login", postAdminlogin);



module.exports = router;