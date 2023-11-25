
const express = require("express");
const router = express.Router();
const db = require('../models');
const { where } = require('sequelize');
const cart = require("../models/cart");
const userUtil = require("../util/userUtil");
const {get_cart : get_cart } = require('../routes/cart_routes');
const paymentService = require('../services/paymentService');
const authent = userUtil.authent;
const StripeUser = db.StripeUser;

// This is your test secret API key.
const stripe = require("stripe")('sk_test_51O49dTDB1UugWx3SlwFKiiQc8JDwiBU5QX343MsHyZKRmgXN16V4vYSn46NOjm1pSHXgF6kXiDL9FZ2MkuYe17xH00Vx06mKID');

router.use(express.urlencoded({ extended: true }));

router.post("/create-payment-intent", async (req, res) => {  
    const userDetails = await userUtil.check_email(req.cookies.emailId);
    const customerId = paymentService.fetchCustomerFromStripe(userDetails);
    const total = await paymentService.calculateTotal(userDetails);
    // Create a PaymentIntent with the order amount and currency
    const paymentIntent = await stripe.paymentIntents.create({
        customer: customerId,
        // setup_future_usage: "off_session",
        amount: total * 100,
        currency: "usd",
        // In the latest version of the API, specifying the `automatic_payment_methods` parameter is optional because Stripe enables its functionality by default.
        automatic_payment_methods: {
            enabled: true,
        },
    });

    res.send({
        clientSecret: paymentIntent.client_secret,
    });
});

//export router
module.exports = router;