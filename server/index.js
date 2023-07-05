//192.168.1.12
//import
const express = require('express')
const mongoose =require('mongoose')

// IMPORTS FROM OTHER FILES
// const adminRouter = require("./routes/admin");
const authRouter = require("./routes/auth");
const authRouterMedecin = require("./routes/authMedecin");
const authRouterPharmacien = require("./routes/authPharmacien");
const authRouterAppointment = require("./routes/appointment_booking");
const authRouterNotification = require('./routes/notification_trigger');


//init
const app = express()
const PORT = process.env.PORT || 3000;
const DB = "mongodb+srv://riad:riad@cluster0.v7srnvh.mongodb.net/?retryWrites=true&w=majority";


//middleware
app.use(express.json());
app.use(authRouter);
app.use(authRouterMedecin);
app.use(authRouterPharmacien);
app.use(authRouterAppointment);
app.use(authRouterNotification);

// Connections
mongoose.connect(DB)
    .then(() => {
        console.log("Connection Successful");
    })
    .catch((e) => {
        console.log(e);
    });

app.listen(PORT,'0.0.0.0',function () {
    console.log(`connected at ${PORT}`)
})