const express = require("express");
const router = express.Router();

const db = require('../models');
const { where } = require('sequelize');
const Catalog = db.Catalog;
const ItemListing = db.ItemListing;
const UserUtil = require('../util/userUtil');
