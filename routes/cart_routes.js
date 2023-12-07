
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
const EasyPostClient = require('@easypost/api');
const sendOTP  = require("../services/controller");
const router = express.Router();
const db = require('../models');
const { where } = require('sequelize');
const cart = require("../models/cart");
const userUtil = require("../util/userUtil");
const authent = userUtil.authent;
const User = db.User;
const EndUser = db.EndUsers;
const Cart = db.Cart;
const ItemListing = db.ItemListing;
const Purchase =  db.Purchase;
const Order = db.Order;


const Catalog = db.Catalog;
const Promocode = db.Promocode;

router.use(express.urlencoded({ extended: true }));

async function get_cart(userId)
{
    let cartDetails = [];
    let listingIds = [];

    const cartDetailsSQL = await Cart.findAll({where:{userId:userId}})

    for (var i = 0; i < cartDetailsSQL.length; i++) 
    {

        // listing id and quantity for each listing in cart
        var listingId = cartDetailsSQL[i].dataValues.listingId;
        var quantity = cartDetailsSQL[i].dataValues.quantity;

        //append listing id and quantity to cartDetails
        cartDetails.push({
                            listingId:listingId, 
                            quantity:quantity
                        });
        
        //append listing id to listingIds
        listingIds.push(listingId);
    
    }

    //get the result of listing details from db
    const listingDetailsSQL = await ItemListing.findAll({where:{listingId:listingIds}});

    itemIDs = []

    // add name and price to cartDetails for that listing id
    for (var i = 0; i < cartDetails.length; i++) 
    {
        for (var j = 0; j < listingDetailsSQL.length; j++) 
        {
            if(cartDetails[i].listingId == listingDetailsSQL[j].dataValues.listingId)
            {
                cartDetails[i].price = listingDetailsSQL[j].dataValues.price;
                itemIDs.push(listingDetailsSQL[j].dataValues.itemId);
            }
        }
    }

    //get name from catalog for each item id
    const itemDetailsSQL = await Catalog.findAll({where:{itemId:itemIDs}});

    // add name to cartDetails for that listing id

    for (var i = 0; i < cartDetails.length; i++)
    {
        for (var j = 0; j < itemDetailsSQL.length; j++) 
        {
            if(itemDetailsSQL[j].dataValues.itemId == itemIDs[i])
            {
                cartDetails[i].name = itemDetailsSQL[j].dataValues.name;
            }
        }
    }

    return cartDetails;
}



router.post('/add-itemlisting', async (req, res)=>
{
    console.log("add-itemlisting inside ------------------------")

    //get authentication status and user id
    // const [authentication, userid] = await authent(req,res);
    if (!userUtil.authenticateToken(req.cookies.accessToken)) {
        // If not authenticated, send a 401 Unauthorized response
        return res.status(401).send('Authentication failed');
      }
    const userDetails = await userUtil.check_email(req.cookies.emailId);

    if(!userDetails.userid)
    {
        return;
    }

    const userId = userDetails.userid;

    //parse listingId from request
    //parse query parameters
    console.log("req data: ", req.body);
    // console.log("req.query: ", JSON.parse(req.body));
    const data = req.body;
    const listingId = data.listingId;

    // const listingId = req.body.listingId;

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
    const listingIdExistsInCart = await Cart.findOne({where:{listingId:listingId, userId:userId}});

    if(listingIdExistsInCart)
    {
        //return 409 error - listingId already exists in cart
        res.status(409).send("listingId already exists in cart");
        console.log("listingId already exists in cart");
        return;
    }

    console.log("my " ,userId, listingId);

    //add listingId to cart
    const addListingId = await Cart.create({userId:userId, listingId:listingId, quantity:1});

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
    var data = req.body;
    // console.log(data_temp);
    // console.log("req.query: ", JSON.parse(req.body));
    // data = JSON.parse(req.body);
    // console.log(data);
    const listingId = data['listingId'];

    console.log("listingId: ", data['listingId']);

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

router.get('/fetch-cart-display', async (req, res)=>
{
    //get authentication status and user id
    const [authentication, userId] = await authent(req,res);
    
    if(!authentication)
    {
        return;
    }
    
    console.log("fetch-cart inside ------------------------")


    //get cart details
    const cartDetails = await get_cart(userId);
    if (!userUtil.authenticateToken(req.cookies.accessToken)) {
        // If not authenticated, send a 401 Unauthorized response
        return res.status(401).send('Authentication failed');
      }
    userDetails = await userUtil.check_email(req.cookies.emailId);
    const username = userDetails.name;

    console.log("cartDetails: ", cartDetails);

    //return cart details
    res.render('cart',{ cartDetails, username });
    // res.status(200).send(cartDetails);

});

router.post('/fetch-cart-display', async (req, res)=>
{
    //get authentication status and user id
    const [authentication, userId] = await authent(req,res);
    
    if(!authentication)
    {
        return;
    }
    console.log("fetch-cart inside ------------------------")
    //display 
    console.log("req.body: ", req.body);

    res.redirect('/cart/get-final-cost');

});

router.get('/fetch-cart', async (req, res)=>
{
    console.log("fetch-cart inside ------------------------")

    console.log(req.cookies)

    //get authentication status and user id
    const [authentication, userId] = await authent(req,res);

    if(!authentication)
    {
        return;
    }

    //get cart details
    const cartDetails = await get_cart(userId);
    
    console.log("cartDetails: ", cartDetails);
    
    //add total price to cartDetails
    for (var i = 0; i < cartDetails.length; i++) 
    {
        cartDetails[i].totalPrice = cartDetails[i].price * cartDetails[i].quantity;
    }



    //return cart details
    res.status(200)
    res.send(cartDetails);

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
    const promoCode1 = req.body.promocode;

    console.log("promoCode: ", promoCode1);

    //check if promoCode exists in db
    const promoCodeData = await Promocode.findOne({where:{promocode:promoCode1}});

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

router.get('/orderplace', async (req, res) => { 
    
    console.log("orderplace inside ------------------------")
    res.render('orderplace') 
});


router.get('/get-final-cost', async (req, res)=>
{
    console.log("get-final-cost inside ------------------------")
    
    //get authentication status and user id
    const [authentication, userId] = await authent(req,res);
    
    if(!authentication)
    {
        return;
    }
   
    
    if(!userId)
    {
        return;
    }
    //get cart body
    let cartDetails = await get_cart(userId)

    total_price = 0;
    // calculate total price of each listing
    for (var i = 0; i < cartDetails.length; i++) 
    {
        cartDetails[i].totalPrice = cartDetails[i].price * cartDetails[i].quantity;
        total_price += cartDetails[i].totalPrice;
    }


    console.log("cartDetails:  1 ", cartDetails);

    promocode = 50

    sales = total_price*0.1
    finalPrice = total_price - promocode + sales

    //convert to string
    total_price = total_price.toString();
    promoCode = promocode.toString();




    res.render('checkout',{
        cartDetails:cartDetails,
        TotalPrice:total_price,
        Promocode: promocode,
        Sales:sales,
        FinalPrice:finalPrice
    });
//    res.render()


});

router.post('/checkout', async (req, res)=>
{
    console.log("checkout inside ------------------------")
    if (req.cookies.emailId) {
        const emailId = req.cookies.emailId;
        var userDetails = await db.User.findOne({where: {emailId}});
        const userid = userDetails.dataValues.userid;

        const endUserDetails = await EndUser.findOne({where: {userId: userid}});


        //get authentication status and user id
        const [authentication, userId] = await authent(req, res);

        if (!authentication) {
            return;
        }

        console.log("req.body: ", req.body);


        //get payment details

        //get cart details
        const cartDetails = await get_cart(userid);

        //get total price
        total_price = 0;
        for (var i = 0; i < cartDetails.length; i++) {
            total_price += cartDetails[i].price * cartDetails[i].quantity;
        }

        //update quantity in itemlisting
        for (var i = 0; i < cartDetails.length; i++) {
            const updateQuantity = await ItemListing.update({quantity: cartDetails[i].quantity - cartDetails[i].quantity}, {where: {listingId: cartDetails[i].listingId}});
        }

        // Victor's Code
        const EASYPOST_API_KEY = 'EZTKf21d82fc6abc492ca6f36522677d267aLtEijfmNnjsHlbQLWWYG4w';
        const client = new EasyPostClient(EASYPOST_API_KEY);
        let shipmentId;

        await (async () => {
            let shipment;

            shipment = await client.Shipment.create({
                to_address: {
                    name: userDetails.dataValues.name,
                    street1: endUserDetails.address_line1,
                    city: endUserDetails.address_city,
                    state: endUserDetails.address_state_code,
                    zip: endUserDetails.address_zipcode,
                    country: 'US',
                    email: userDetails.emailId,
                    phone: endUserDetails.phone_nr,
                },
                from_address: {
                    street1: '417 montgomery street',
                    street2: 'FL 5',
                    city: 'San Francisco',
                    state: 'CA',
                    zip: '94104',
                    country: 'US',
                    company: 'EasyPost',
                    phone: '415-123-4567',
                },
                parcel: {
                    length: 20.2,
                    width: 10.9,
                    height: 5,
                    weight: 65.9,
                },
                customs_info: null,
            });
            shipmentId = shipment.id;
            console.log(shipment);
        })();

        const paymentId = req.body["paymentID"];
        const purchase = await db.Purchase.create({paymentId: paymentId, shipmentId: shipmentId, total_price: total_price, userId: userid});
        console.log("Auto-generated ID for Purchase: ", purchase.purchaseId);

        for (var i = 0; i < cartDetails.length; i++) {
            const order = await Order.create({listingId: cartDetails[i].listingId, purchaseId: purchase.purchaseId, quantity: cartDetails[i].quantity, total_cost_of_item: cartDetails[i].price * 1.1, return_status: "not requested"});
            console.log("Auto-generated Order ID: ", order.orderId);
        }


        console.log("cartDetails: ", cartDetails);

        const tax = 0.1 * total_price;
        const promoCode = 50;
        const finalPrice = total_price + tax - promoCode;

        console.log("Final Price: ", total_price);


        //delete cart details from db
        const deleteCartDetails = await Cart.destroy({where: {userId: userid}});

        //update quantity in itemlisting

        //victors code

    }
});


//export router
module.exports = { router, get_cart};