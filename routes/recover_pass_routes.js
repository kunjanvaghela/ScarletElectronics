const express = require("express");
const sendOTP  = require("../services/controller");
const router = express.Router();
const db = require('../models');
const { where } = require('sequelize');
const { encrypt, decrypt } = require('../util/encryptionUtil'); // Assuming the encryptionUtil.js file is in the same directory
const OTP = db.OTP;
const User = db.User;


router.post('/update', async(req, res) =>{
    try{
        console.log(req.body);
        const {emailId , password1, password2} = req.body;
        const user = await User.findOne({where:{emailId:emailId}});

        if(user)
        {
            user.password = password1;
            user.save();
            console.log("Password Changed Sucessfully");
            res.status(200).send("Welcome Home");
            return;
        }
        else
        {
            console.log("User not found");
            res.status(400).render('recover-password');
            return;
        }
    }
    catch(err)
    {
        console.log("Error Occured " + err);
        res.status(400).render('recover-password');
        return;
    }
})

router.post('/', async (req, res)=>{
    try{
        console.log(req.body);
        const { OTP_val, emailId}  = req.body;
        
        const dbOTP = await OTP.findOne({where:{emailId:emailId}});
        console.log("Details from DB " + dbOTP.emailId + " " + dbOTP.otp + " " +  OTP_val);
        if(dbOTP)
        {
            if(dbOTP.otp === OTP_val && dbOTP.expires_on >= Date.now())
            {
                res.status(200).render("recover-password", {emailId : emailId});
                return;
            }
            else
            {
                res.status(400).send("Use the latest OTP");
                return;
            }
        }

    }
    catch(err)
    {
        console.log("Here Error Caught" + err);
    }
});


router.get('/', async (req, res)=>{
    console.log("Get/ Reset-Password");
    res.send(req.body);
});

module.exports = router;