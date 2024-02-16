# Scarlet Electronics E-Commerce Platform

Welcome to Scarlet Electronics, an advanced E-commerce platform designed for seamless electronics transactions. This web application offers a secure environment for buyers and sellers to engage in online transactions with confidence.

## Introduction

Scarlet Electronics provides a comprehensive solution for online electronics transactions. From user registration to purchase history and customer support, our platform is designed to enhance the user experience and ensure data security.

## Key Features

1. **Accounts and Authentication:**
   - Robust registration and authentication process.
   - PII encryption with AES-256 for user data security.
   - Google reCaptcha v2 integration for protection against attacks.

2. **E-commerce Functionality:**
   - Buyers and sellers can register and enjoy platform functionalities.
   - Sellers can list items, update stock, and adjust prices.
   - Buyers can add items to the shopping cart, update quantities, and checkout.
   - Auto-bidding feature enhances the auction experience.

3. **Advanced Search and Recommendations:**
   - Various search filters for easy item discovery.
   - Recommendations based on product type and user history.

4. **Purchase History and Returns:**
   - Users can view past purchases, initiate returns, and track deliveries.
   - Seamless return process with order status updates.

5. **Reviews and Ratings:**
   - Users can post, edit, or delete reviews on purchased products.
   - Average ratings displayed on the product detail page.

6. **Security and Data Privacy:**
   - PII encryption and secure communication protocols (HTTPS).
   - JWT for secure user credential transmission.

7. **Customer Support and Feedback:**
   - Integrated chatbot powered by Chatbase for quick user support.
   - Users can report queries and provide feedback to customer support.

8. **Payment Processing:**
   - Secure payment processing through Stripe.
   - Billing includes taxes and applied discounts.

## Tech Stack

The Scarlet Electronics E-commerce platform is built on a robust tech stack that combines various technologies for seamless functionality. Here are the key technologies and libraries used in the project:

- **Node.js (Express):** Utilized as the server-side runtime environment, Express provided a minimal and flexible framework for building web applications.

- **MySQL:** Leveraged for database management, MySQL ensured efficient storage and retrieval of data, maintaining the integrity of the platform's information.

- **Sequelize:** Used as an ORM (Object-Relational Mapping) for Node.js, Sequelize facilitated interaction with the MySQL database, simplifying data manipulation and storage.

- **EJS (Embedded JavaScript):** Employed as the templating engine, EJS allowed for dynamic content generation on the server side, enhancing the user interface.

- **JWT (JSON Web Tokens):** Implemented for secure transmission of user credentials and streamlined authentication across the entire platform.

- **Axios:** Used for making HTTP requests, Axios facilitated communication with external APIs and services, enhancing functionality such as Google reCaptcha and Easypost integration.

- **Dotenv:** Employed for managing environment variables, Dotenv ensured a secure and configurable setup for the application.

- **Nodemon:** Used in development for automatic server restarts upon file changes, enhancing the development workflow.

- **Stripe:** Integrated for secure payment processing, Stripe ensured a reliable and smooth transaction experience for users.

- **Easypost API:** Utilized for easy integration with a third-party courier service, providing users with accurate delivery tracking links.

- **Nodemailer:** Implemented for sending transactional emails, Nodemailer facilitated communication with users, including password reset OTPs and notifications.

- **@google-cloud/recaptcha-enterprise:** Integrated for Google reCaptcha v2 to enhance security and protect against various attacks.

- **GoogleApis:** Utilized for Google Drive integration, allowing the platform to store and access images seamlessly.

- **Multer:** Implemented for accepting multiple images, enhancing the platform's capabilities for product listings and catalog management.

- **CleverCloud:** Utilized for maintaining a single database hosted on the internet among multiple contributors, ensuring a centralized and collaborative database management approach.




## Getting Started

Follow these steps to set up and run Scarlet Electronics:

1. **Clone Repository:**

   ```git clone https://github.com/kunjanvaghela/ScarletElectronics```

2. **Checkout Main Branch:**

    ```git checkout main ```

3. **Configure Database:**

    Create database from the schema present in resources/databasedump.sql file. Edit the 'development' confguration to your database's hosting in config/config.json file.

4. **Install Dependencies:**

    ```npm install```

5. **GoogleAPI Setup:**

    Place the service account key file ('scarletelectronics-key.json') in the 'util' folder. Create your own access using 'Authentication Method = Service account' as provided in Google Developers documentation (Refer: https://developers.google.com/workspace/guides/create-credentials#service-account).

6. **Run Server:**

    Use one of the following commands to start the server from project's main directory:

    ```npm start```

    or,

    ```npm run devStart```

7. **Access Platform:**

    Navigate to [http://localhost:3000/users/home](http://localhost:3000/users/home) to get started.

    - **Username:** kunjan.vaghela@rutgers.edu
    - **Password:** Kunj123!

    or,

    - **Username:** jimrichards1920@gmail.com
    - **Password:** TEST@1234


## Contribution

This project was a collaborative effort, and the following outlines my (Kunjan) specific contributions:

### Developer Contributions:

1. **Create Listing Page:**
   - Implemented the feature allowing sellers to create listings only for items present in Scarlet Electronic's product catalog.
   - Developed the GUI for creating listings and fetching available products from the Product Catalog.

2. **Listings Page:**
   - Implemented the feature to fetch all available listings in Scarlet Electronics, enhancing the user browsing experience.
   - Developed a user-friendly interface for end-users and visitors to view an overview of available listings, along with database fetch operations.

3. **Product Page:**
   - Created functionality to retrieve detailed information about a specific product, enhancing the overall user experience.
   - Implemented features for ratings while collaborating with other contributors for the review functionality.

4. **GoogleDrive API Integration:**
   - Integrated operations to add product images to Google Drive, storing only the product's folder ID in the ScarletElectronic's database.

5. **Visitor and End User Headers:**
   - Enhanced the design and functionality of headers for both visitors and end-users.

6. **Log Out Functionality:**
   - Created the initial version of the Log Out functionality, involving cookie deletion for improved security.

### Major Bug Fixes:

1. **Add Product in Product Catalog:**
   - Utilized the Multer library to accept and store images from the frontend to the backend.

2. **User Registration Bug Fix:**
   - Implemented IsA relationship to include details in the 'users' parent table and the 'end_user' child table during end user registration.

### Major Design Contributions (Apart from Features Developed Individually):

1. **Database Tables Designing and Hosting:**
   - Contributed to the design of database structure and hosting of the database on cloud platform for efficient data management across all contributors.

2. **Image Storage and Retrieval Structure:**
   - Designed the structure for storing and retrieving product images.

3. **Designing Structure for Customer Support Representative:**
   - Contributed to the design of the structure for Customer Support Representative functionalities.

4. **Structure of Use of StripeAPI and EasyPostAPI:**
   - Contributed to the design structure for integrating StripeAPI and EasyPostAPI for payment processing and delivery tracking.


For any inquiries regarding the project, feel free to contact me at [kunjanvaghela@gmail.com](mailto:kunjanvaghela@gmail.com).

We hope you enjoy the Scarlet Electronics E-commerce experience! Happy buying and selling!