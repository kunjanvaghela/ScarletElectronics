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
            const createdOPT = await sendOTP({email:emailId,subject :"OPT Verification from ScarletElectronics", message:"This is message for OTP verification", duration :1});
            
            res.status(200).render('otp_validation', {emailId});
            return;
        }
        else
        {   
            res.status(400).render('forgot-password');
        }
        
    }
    catch(err)
    {
        console.log("Error Caught" + err);
    }
});


router.get('/', async (req, res)=>{
    console.log("Get/ Reset-Password");
    res.send(req.body);
});

module.exports = router;