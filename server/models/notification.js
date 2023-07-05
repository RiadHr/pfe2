const mongoose= require("mongoose");

// Define the notification schema
const notificationSchema = mongoose.Schema({
    userId: { type: String, required: true },
    doctorId: { type: String, required: true },
    dateTime: { type: String, required: true },
    userName: { type: String,},
    doctorName: { type: String,},
    time:{type:String, required:true}
});

// Create the notification model
// const Appointment = mongoose.model('Appointment', notificationSchema);


module.exports = notificationSchema;