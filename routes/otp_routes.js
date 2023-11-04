const express = require("express");
const sendOTP  = require("../services/controller");
const router = express.Router();
const db = require('../models');
const { where } = require('sequelize');
const User = db.User;
const OTP = db.OTP;

router.post('/', async (req, res)=>{
    
    try{
        const { emailId } = req.body;
        const user_email = await  User.findOne({where: {emailId: emailId}});
        if(user_email !== null)
        {
            const dbemail = user_email.get({ plain: true });
            await OTP.destroy({where:{emailId: emailId}});
            console.log("Found User: ", dbemail);
            const createdOPT = await sendOTP({email:emailId,subject :"OTP Verification from ScarletElectronics", message:"This is message for OTP verification", duration :1});
            
            res.header('Cache-Control', 'no-cache, no-store, must-revalidate');
            res.header('Pragma', 'no-cache');
            res.header('Expires', 0);
            res.status(200).render('otp_validation', {emailId});
            return;
        }
        else
        {   

            res.status(400).render('forgot-password', {message : "User not found. Please sign up first!!"});
        }
        
    }
    catch(err)
    {
        console.log("Error Caught" + err);
        res.status(400).redirect('/users/login');
    }
});


router.get('/', async (req, res)=>{
    console.log("Get/ Reset-Password");
    res.send(req.body);
});

module.exports = router;