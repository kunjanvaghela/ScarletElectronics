const IV_LENGTH = 16;

/*
   CREATE TABLE IF NOT EXISTS `bjy4c3bfqe9mnlvfzpwb`.`cart` (
  `cartId` INT NOT NULL AUTO_INCREMENT,
  `listingId` INT UNSIGNED NOT NULL,
  `userId` INT UNSIGNED NOT NULL,
  `quantity` INT NOT NULL,
*/

const Catalog = sequelize.define('Cart', 
{
    cartId: 
    {
        type: DataTypes.INTEGER.UNSIGNED,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
    },
    listingId: 
    {
        type: DataTypes.INTEGER.UNSIGNED,
        allowNull: false,
    },
    userId: 
    {
        type: DataTypes.INTEGER.UNSIGNED,
        allowNull: false,
    },
    quantity: 
    {
        type: DataTypes.INTEGER.UNSIGNED,
        allowNull: false,
    }
});

Catalog.sync({ force: false }).then(() => {
    console.log("Catalog table synced");
});

module.exports = Catalog;

