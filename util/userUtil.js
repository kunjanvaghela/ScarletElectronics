const db = require('../models');
const EndUser = db.EndUsers;
const User = db.User;
const jwt = require('jsonwebtoken');

async function check_email(emailId)
{
    try{
        //parse emailId from request
        //parse query parameters
        console.log("emailId: ", emailId);
        // const emailId = req.body.emailId;
    
        if(emailId === undefined) {
            return false;
        }
        const user_email = await  User.findOne({where: {'emailId': emailId}});
        if(user_email !== null) {
            const dbemail = user_email.get({ plain: true });
            //console.log("Found User: ", dbemail);
            
            //get details of user from db
            const user_details = await User.findOne({where:{emailId:emailId}});
            return user_details;
        }
        else {
            console.log("User not found");
            return false;
        }
    }
    catch(err) {
        console.log("Error Caught" + err);
        return false;
    }
}

function authenticateToken(token) {
    console.log('Working1');
    console.log('token::', token);

    if (token == null) return false;

    try {
        jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
        return true;
    } catch (error) {
        console.log('JWT verification error:', error);
        return false;
    }
}
async function authent(req,res)
{
    console.log("authent inside ------------------------");
    if (!authenticateToken(req.cookies.accessToken)) {
        res.status(401).send('Authentication failed');
        return [false, null];
    }
    authentication = await check_email(req.cookies.emailId);

    if(!authentication)
    {
        //return invalid authorization token
        res.status(401);
        console.log("Invalid Authorization Token");
        res.render('loginPage');
        return [false, null];
    }

    console.log("user id: ", authentication.dataValues.userid);
    //get cart details from db

    //return authentication_status and user id
    return [true, authentication.dataValues.userid];
}

function generateAccessToken(tokenPackage) {
	return jwt.sign(tokenPackage, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '900s' });
}
module.exports = { check_email,authenticateToken,generateAccessToken ,authent};