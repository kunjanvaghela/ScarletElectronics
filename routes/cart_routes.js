
/*

Add Itemlisting	                cart/add-itemlisting	       POST	token, listingId
Update Itemlisting	            cart/update-itemlisting	       PUT	token, listingId, updateCount
Remove Itemlisting	            cart/remove-itemlisting	       DELETE	token, listingId
Fetch Cart	                    cart/fetch-cart	                GET	token 
Flush Cart	                    cart/flush	                    DELETE	token
Get Payment Information	        cart/get-payment-information	GET	token
Add Payment Information	        cart/add-payment-information	POST	token, nameOnCard, billingAddress, CardNumber
Fetch Address	                cart/fetch-address	            GET	token
Get Shipping charges and taxes	cart/display-shipping-charges	GET	token, selectedAddressStateCode
Check Promo Code	            cart/check-promo-code	        GET	promoCode
Calculate Final Cost	        cart/get-final-cost	            GET	token, promoCode, selectedAddressStateCode
Checkout	                    cart/checkout	                POST	token, selectedAddress, promoCode
*/

const express = require("express");
const sendOTP  = require("../services/controller");
const router = express.Router();
const db = require('../models');
const { where } = require('sequelize');
const cart = require("../models/cart");
const User = db.User;
const Cart = db.Cart;
const ItemListing = db.ItemListing;
const Catalog = db.Catalog;
const Promocode = db.Promocode;

router.use(express.urlencoded({ extended: true }));


async function check_email(req,res)
{
    try{

        //parse emailId from request
        //parse query parameters
        console.log("req.body: ", req.body);
        const emailId = req.body.emailId;
    
        if(emailId === undefined)
        {
            return false;
        }
        const user_email = await  User.findOne({where: {'emailId': emailId}});
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

async function authent(req,res)
{
    console.log("authent inside ------------------------");
    console.log(req.body);
    authentication = await check_email(req,res)

    if(!authentication)
    {
        //return invalid authorization token
        res.status(401).send("Invalid Authorization Token");
        console.log("Invalid Authorization Token");
        return [false, null];
    }

    console.log("user id: ", authentication.dataValues.userid);
    //get cart details from db

    //return authentication_status and user id
    return [true, authentication.dataValues.userid];
}

router.post('/add-itemlisting', async (req, res)=>
{
    console.log("add-itemlisting inside ------------------------")

    //get authentication status and user id
    const [authentication, userid] = await authent(req,res);
    
    if(!authentication)
    {
        return;
    }

    //parse listingId from request
    //parse query parameters
    console.log("req.query: ", req.body);
    const listingId = req.body.listingId;

    console.log("listingId: ", listingId);

    //check if listingId exists in db
    const listingIdExists = await ItemListing.findOne({where:{listingId:listingId}});

    if(!listingIdExists)
    {
        //return 404 error - listingId does not exist in db
        res.status(404).send("listingId does not exist in db");
        console.log("listingId does not exist in db");
        return;
    }

    //check if listingId already exists in cart
    const listingIdExistsInCart = await Cart.findOne({where:{listingId:listingId, userId:userid}});

    if(listingIdExistsInCart)
    {
        //return 409 error - listingId already exists in cart
        res.status(409).send("listingId already exists in cart");
        console.log("listingId already exists in cart");
        return;
    }

    //add listingId to cart
    const addListingId = await Cart.create({userId:userid, listingId:listingId, quantity:1});

    //return success message
    res.status(200).send("listingId added to cart successfully");

});


router.post('/update-itemlisting', async (req, res)=>
{
    console.log("update-itemlisting inside ------------------------")

    //get authentication status and user id
    const [authentication, userid] = await authent(req,res);
    
    if(!authentication)
    {
        return;
    }

    //parse listingId from request
    //parse query parameters
    console.log("req.query: ", req.body);
    const listingId = req.body.listingId;
    const updateCount = req.body.updateCount;

    console.log("listingId: ", listingId);
    console.log("updateCount: ", updateCount);

    if (updateCount < 0)
    {
        //return 400 error - updateCount cannot be negative
        res.status(400).send("updateCount cannot be negative");
        console.log("updateCount cannot be negative");
        return;
    }

    if (updateCount == 0)
    {
        //remove listingId from cart
        const deleteListingId = await Cart.destroy({where:{userId:userid, listingId:listingId}});
        //return success message
        res.status(200).send("listingId deleted from cart successfully");
        return;
    }

    //check if listingId exists in db
    const listingIdExists = await ItemListing.findOne({where:{listingId:listingId}});

    //check if listingId already exists in cart
    const listingIdExistsInCart = await Cart.findOne({where:{listingId:listingId, userId:userid}});

    if(!listingIdExistsInCart)
    {
        //return 404 error - listingId does not exist in cart
        res.status(404).send("listingId does not exist in cart");
        console.log("listingId does not exist in cart");
        return;
    }

    //update listingId in cart
    const updateListingId = await Cart.update({quantity:updateCount},{where:{userId:userid, listingId:listingId}});

    //return success message
    res.status(200).send("listingId updated in cart successfully");

});


router.post('/remove-itemlisting', async (req, res)=>
{
    console.log("remove-itemlisting inside ------------------------")

    //get authentication status and user id
    const [authentication, userid] = await authent(req,res);
    
    if(!authentication)
    {
        return;
    }

    //parse listingId from request
    //parse query parameters
    console.log("req.query: ", req.body);
    const listingId = req.body.listingId;

    console.log("listingId: ", listingId);

    //check if listingId exists in db
    const listingIdExists = await ItemListing.findOne({where:{listingId:listingId}});

    //check if listingId already exists in cart
    const listingIdExistsInCart = await Cart.findOne({where:{listingId:listingId, userId:userid}});

    if(!listingIdExistsInCart)
    {
        //return 404 error - listingId does not exist in cart
        res.status(404).send("listingId does not exist in cart");
        console.log("listingId does not exist in cart");
        return;
    }

    //delete listingId from cart
    const deleteListingId = await Cart.destroy({where:{userId:userid, listingId:listingId}});

    //return success message
    res.status(200).send("listingId deleted from cart successfully");

});


router.get('/fetch-cart', async (req, res)=>
{
    console.log("fetch-cart inside ------------------------")
    //get authentication status and user id
    // const [authentication, userid] = await authent(req,res);
    // const [userid] = await authent(req,res);
    

    // console.log("authentication: ", authentication);
    // if(!authentication)
    // {
    //     return;
    // }

    let cartDetails = [];
    let listingIds = [];

    // const cartDetailsSQL = await Cart.findAll({where:{userId:userid}})

    // for (var i = 0; i < cartDetailsSQL.length; i++) 
    // {

    //     // listing id and quantity for each listing in cart
    //     var listingId = cartDetailsSQL[i].dataValues.listingId;
    //     var quantity = cartDetailsSQL[i].dataValues.quantity;

    //     //append listing id and quantity to cartDetails
    //     cartDetails.push({
    //                         listingId:listingId, 
    //                         quantity:quantity
    //                     });
        
    //     //append listing id to listingIds
    //     listingIds.push(listingId);
    
    // }

    // //get the result of listing details from db
    // const listingDetailsSQL = await ItemListing.findAll({where:{listingId:listingIds}});

    // itemIDs = []

    // // add name and price to cartDetails for that listing id
    // for (var i = 0; i < cartDetails.length; i++) 
    // {
    //     for (var j = 0; j < listingDetailsSQL.length; j++) 
    //     {
    //         if(cartDetails[i].listingId == listingDetailsSQL[j].dataValues.listingId)
    //         {
    //             cartDetails[i].price = listingDetailsSQL[j].dataValues.price;
    //             itemIDs.push(listingDetailsSQL[j].dataValues.itemId);
    //         }
    //     }
    // }

    // //get name from catalog for each item id
    // const itemDetailsSQL = await Catalog.findAll({where:{itemId:itemIDs}});

    // // add name to cartDetails for that listing id

    // for (var i = 0; i < cartDetails.length; i++)
    // {
    //     for (var j = 0; j < itemDetailsSQL.length; j++) 
    //     {
    //         if(itemDetailsSQL[j].dataValues.itemId == itemIDs[i])
    //         {
    //             cartDetails[i].name = itemDetailsSQL[j].dataValues.name;
    //         }
    //     }
    // }

    cartDetails = [
        {
            "listingId": 2,
            "quantity": 2,
            "price": 1200.78,
            "name": "iPhone 13"
        },
        {
            "listingId": 3,
            "quantity": 4,
            "price": 580,
            "name": "Samsung Galaxy S21"
        },
        {
            "listingId": 4,
            "quantity": 2,
            "price": 2300,
            "name": "Dell XPS 13"
        }
    ];


    console.log("cartDetails: ", cartDetails);

    //return cart details
    res.render('cart',{ cartDetails });
    // res.status(200).send(cartDetails);

});

router.post('/flush', async (req, res)=>
{
    console.log("flush inside ------------------------")

    //get authentication status and user id
    const [authentication, userid] = await authent(req,res);
    
    if(!authentication)
    {
        return;
    }

    //delete cart details from db
    const deleteCartDetails = await Cart.destroy({where:{userId:userid}});

    //return success message
    res.status(200).send("Cart flushed successfully");
});



router.get('/get-payment-information', async (req, res)=>
{
    console.log("get-payment-information inside ------------------------")

});

router.post('/add-payment-information', async (req, res)=>
{
    console.log("add-payment-information inside ------------------------")

});

router.get('/fetch-address', async (req, res)=>
{
    console.log("fetch-address inside ------------------------")

});

router.get('/display-shipping-charges', async (req, res)=>
{
    console.log("display-shipping-charges inside ------------------------")

});

router.post('/check-promo-code', async (req, res)=>
{
    console.log("check-promo-code inside ------------------------")

    //parse promoCode from request
    //parse query parameters
    console.log("req.query: ", req.body);
    const promoCode = req.body.promoCode;

    console.log("promoCode: ", promoCode);

    //check if promoCode exists in db
    const promoCodeData = await Promocode.findOne({where:{promocode:promoCode}});

    if(!promoCodeData)
    {
        //return 404 error - promoCode does not exist in db
        res.status(404).send("promoCode does not exist in db");
        console.log("promoCode does not exist in db");
        return;
    }

    // check if promoCode is active
    if(promoCodeData.dataValues.is_active == false)
    {
        //return 400 error - promoCode is not active
        res.status(400).send("promoCode is not active");
        console.log("promoCode is not active");
        return;
    }

    //return success message
    res.status(200).send("promoCode is active");
    

});

router.get('/get-final-cost', async (req, res)=>
{
    console.log("get-final-cost inside ------------------------")

});



//export router
module.exports = router;