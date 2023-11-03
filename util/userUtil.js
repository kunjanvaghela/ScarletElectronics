const db = require('../models');
const EndUser = db.EndUsers;
const User = db.User;


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
            console.log("Found User: ", dbemail);
            
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



async function authent(req,res)
{
    console.log("authent inside ------------------------");
    console.log(req.body);
    authentication = await userUtil.check_email(req.cookies.emailId);

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


module.exports = { check_email, authent };