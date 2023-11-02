module.exports = (sequelize, DataTypes) => {
    const ItemListing = sequelize.define('Staff', {
        listingId: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        itemId: {
            type: DataTypes.INTEGER,
            allowNull: false,
        },
        sellerId: {
            type: DataTypes.INTEGER,
            allowNull: false,
        },
        price: {
            type: DataTypes.FLOAT,
            allowNull: false,
            validate: {
                min: 0,
            },
        },
        created_on: DataTypes.DATE,
        created_by: DataTypes.STRING,
        remarks: DataTypes.STRING,
        updated_by: DataTypes.STRING,
        updated_on: DataTypes.DATE,
        quantity: {
            type: DataTypes.INTEGER,
            defaultValue: 0,
            validate: {
                min: 0,
            },
        },
    }, {
        sequelize,
        modelName: 'Staff',
        tableName: 'item_listing',
        timestamps: false,  // This will remove the automatic timestamp fields (createdAt, updatedAt)
        //underscored: true,
    }
    );
    return ItemListing;
}