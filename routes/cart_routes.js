const express = require("express");
const sendOTP  = require("../services/controller");
const router = express.Router();
const db = require('../models');
const { where } = require('sequelize');
const User = db.User;



/*
Fetch Cart	                cart/fetch-cart	                GET	token 
Flush Cart	                cart/flush	                DELETE	token
Get Payment Information	        cart/get-payment-information	GET	token
Add Payment Information	        cart/add-payment-information	POST	token, nameOnCard, billingAddress, CardNumber
Fetch Address	                cart/fetch-address	        GET	token
Get Shipping charges and taxes	cart/display-shipping-charges	GET	token, selectedAddressStateCode
Check Promo Code	        cart/check-promo-code	        GET	promoCode
Calculate Final Cost	        cart/get-final-cost	        GET	token, promoCode, selectedAddressStateCode
Checkout	                cart/checkout	                POST	token, selectedAddress, promoCode
*/

function check_email(req,res)
{
    try{
        const { emailId } = req.body;
        const user_email = await  User.findOne({where: {emailId: emailId}});
        if(user_email !== null)
        {
            const dbemail = user_email.get({ plain: true });
            console.log("Found User: ", dbemail);
            
            //get details of user from db
            user_details = await User.findOne({where:{emailId:emailId}});
            return user_details;
        }
        else
        {   
            //return 404 error - user not found
            res.status(400).send("User not found");
            console.log("User not found");
            return false;
        }
        
    }
    catch(err)
    {
        console.log("Error Caught" + err);
        //return 500 error - Internal Server Error
        res.status(500).send("Internal Server Error");
        return false;
    }
}


router.post('/', async (req, res)=>


}
