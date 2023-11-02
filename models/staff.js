module.exports = (sequelize, DataTypes) => {
    const Staff = sequelize.define('Staff', {
        userId: {
            type: DataTypes.INTEGER,
            primaryKey: true,
        },
        ssn: DataTypes.INTEGER,
        date_of_birth: DataTypes.DATE,
        designation: DataTypes.STRING,
        status: DataTypes.STRING,
        created_on: DataTypes.DATE,
        created_by: DataTypes.STRING,
        remarks: DataTypes.STRING,
        updated_by: DataTypes.STRING,
        updated_on: DataTypes.DATE,
    }, {
        sequelize,
        modelName: 'Staff',
        tableName: 'staff',
        timestamps: false,  // This will remove the automatic timestamp fields (createdAt, updatedAt)
        //underscored: true,
    }
    );
    return Staff;
}