const mongoose = require("mongoose");
const ratingSchema = require("./rating");

const pharmacienSchema = mongoose.Schema({
    name: {required: true,type: String,trim: true,},
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
    password: {required: true, type: String,},
    idMatricule:{required: true, type: String,},
    wilaya:{required : true, type :String},
    daira:{required:true, type:String},
    telephone: {required:true, type: String,},
    anciente:{required:true, type:Number,},
    ratings:[ratingSchema],
    permanance:{required:true,type:Boolean,default:false},
    isBlocked:{required:true,type:Boolean,default:false}
});

const Pharmacien = mongoose.model("Pharmacien", pharmacienSchema);
module.exports = Pharmacien;