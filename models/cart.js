 
module.exports = (sequelize, DataTypes) => {
    const Cart = sequelize.define("Cart", {
        cartId: 
        {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            allowNull: false
        },
        listingId: 
        {
            type: DataTypes.INTEGER,
            allowNull: false,
        },
        userId: 
        {
            type: DataTypes.INTEGER,
            allowNull: false,
        },
        quantity: 
        {
            type: DataTypes.INTEGER,
            allowNull: false,
        }
    },
    {
        sequelize,
        modelName: 'Cart',
        tableName: 'cart',
        timestamps:false,
        //underscored: true,
    });
    
    Cart.sync({ force: false })
    .then(() => {
        console.log('OTP table, if one doesnt exist');
    })
    .catch(error => {
        console.log('This error occured', error);
    });


    return Cart;
}


/*
   CREATE TABLE IF NOT EXISTS `bjy4c3bfqe9mnlvfzpwb`.`cart` (
  `cartId` INT NOT NULL AUTO_INCREMENT,
  `listingId` INT UNSIGNED NOT NULL,
  `userId` INT UNSIGNED NOT NULL,
  `quantity` INT NOT NULL,

}



const Cart = sequelize.define("Cart", {
    cartId: 
    {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
    },
    listingId: 
    {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    userId: 
    {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    quantity: 
    {
        type: DataTypes.INTEGER,
        allowNull: false,
    }
});



module.exports = [Cart, DataTypes]

*/