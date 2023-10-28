console.log('server.js loaded');
const express = require('express');
const app = express();

const mysql = require('mysql2');
const { encrypt, decrypt } = require('./util/encryptionUtil'); // Assuming the encryptionUtil.js file is in the same directory

const db = require('./models');
const User = db.User;
app.use(express.urlencoded({ extended: true }));

app.set('view engine', 'ejs');

app.get('/', (req, res) => {
    console.log('Successfully in Root :Inssss:sss:: /');
    res.render('loginPage');

})

app.get('/register', (req, res) => {
    res.render('register');
});


app.post('/registerUser', async (req, res) => {
    // Get data from request
    const userData = req.body;
    const User = db.User;
    console.log(userData);

    try {
        const user = await User.create(userData);
        // Handle the response after success
        res.redirect('/');  // Redirect to login or any other page
    } catch (error) {
        // Handle the error response
        console.error('Error occurred:', error);
        res.status(500).send('Error occurred');
    }
});

app.post('/login', async (req, res) => {
    // Get data from request
    const { emailId, password } = req.body;

    const User = db.User;

    try {
        const user = await User.findOne({ where: { emailId } });

        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        const decryptedPassword = decrypt(user.encrypted_password);

        if (password !== decryptedPassword) {
            return res.status(401).json({ message: 'You have entered Invalid password, '+user.name+'' });
        }

        return res.status(200).json({ message: 'Welcome '+user.name+',  Login successful' });

    } catch (error) {
        console.error('Error during login:', error);
        return res.status(500).json({ message: 'Internal Server Error' });
    }
});

db.sequelize.sync().then(() => {
    app.listen(3000, () => {
        console.log('Server is running on port 3000')
    });
});