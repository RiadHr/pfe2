const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name: {required: true, type: String, trim: true,},
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
    password: {required: true, type: String,
        validate:{
            validator:(value)=>{
                return value.length>8;
            },
            message: "password contain at least 8 char"
        }
    },
    idn:{required: true, type: String,},
    wilaya:{type:String},
    daira:{type:String},
    telephone: {required:true, type: String,},
    type: {type: String, default: "user",},
    isBlacklisted: [String],
    isBlocked:{type:Boolean,default: false}
});

const User = mongoose.model("User", userSchema);
module.exports = User;