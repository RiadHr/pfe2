const mongoose= require("mongoose");

// Define the appointment schema
const appointmentSchema = mongoose.Schema({
    userId: { type: String, required: true },
    doctorId: { type: String, required: true },
    dateTime: { type: Date, required: true },
    status : {type:String},
    userName: { type: String,},
    doctorName: { type: String,},
    time:{type:String, required:true}
});

// Create the appointment model
// const Appointment = mongoose.model('Appointment', appointmentSchema);


module.exports = appointmentSchema;
