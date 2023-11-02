console.log('server.js loaded');
const express = require('express');
const jwt = require("jsonwebtoken");
const userRouter = require("./routes/user_routes.js");
const addItem = require("./routes/add_item.js");

const mysql = require('mysql2');
const { encrypt, decrypt } = require('./util/encryptionUtil'); // Assuming the encryptionUtil.js file is in the same directory

const db = require('./models');
const { where } = require('sequelize');
const User = db.User;
const OTP = db.OTP;
const Catalog = db.Catalog;

OTP.belongsTo(User, {
    foreignKey: 'emailId',
    targetKey: 'emailId',
    onDelete: 'CASCADE', // Define the onDelete behavior (e.g., CASCADE, SET NULL)
});

const app = express();
app.use(express.urlencoded({ extended: true }));

app.set('view engine', 'ejs');


app.use('/users', userRouter);
app.use('/add-item', addItem);


// app.post('/forgot-password', (req, res, next) => {
//     const  { emailId } = req.body;
//     console.log("In POST forgot Password " + emailId);
//     User.findOne({where: {emailId: emailId}}).then((user) => {
//         console.log("Found User: ", user);
//     }).catch((err) => {
//         console.log("No Users found");
//     });
//     // console.log(req.body);
//     // res.send(emailId);

// });


db.sequelize.sync().then(() => {
    app.listen(3000, () => {
        console.log('Server is running on port 3000')
    });
});