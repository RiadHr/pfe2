const mongoose = require("mongoose");
const ratingSchema = require('./rating');
const appointmentSchema = require('./appointment');
const notificationSchema = require("./notification");

const medecinSchema = mongoose.Schema({
    idMatricule:{required: true,type:String},
    name: {required: true, type: String, trim: true},
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: "Please enter a valid email address",
        },
    },
    password: {required: true, type: String},
    specialite:{required: true, type: String},
    wilaya:{required : true, type :String},
    daira:{required:true, type:String},
    telephone: {required:true, type: String,},
    anciente:{required:true, type:Number,},
    isBlocked:{type:Boolean,default: false},
    ratings:[ratingSchema],
    appointment :[appointmentSchema],
    notifications:[notificationSchema]
});

const Medecin = mongoose.model("Medecin", medecinSchema);
module.exports = Medecin;