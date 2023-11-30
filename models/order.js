
module.exports = (sequelize, DataTypes) => {
    const order = sequelize.define("Order", {
            orderId:
                {
                    type: DataTypes.INTEGER,
                    autoIncrement: true,
                    primaryKey: true,
                    allowNull: false,
                },
            listingId:
                {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                },
            purchaseId:
                {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                },
            quantity:
                {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                },
            total_cost_of_item:
                {
                    type: DataTypes.FLOAT,
                    allowNull: false,
                },
            return_status:
                {
                    type: DataTypes.STRING(50),
                    allowNull: true
                }
        },
        {
            sequelize,
            modelName: 'Order',
            tableName: 'order_detail',
            timestamps:false,
            //underscored: true,
        });

    order.sync({ force: false })
        .then(() => {
            console.log('Order table created, if one doesnt exist');
        })
        .catch(error => {
            console.log('An error occurred', error);
        });

    return order;
}


