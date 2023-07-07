const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

const authMiddleware = require("../middlewares/auth");
const medecinMiddleware = require("../middlewares/medecinMiddleware");
const pharmacienMiddleware = require("../middlewares/pharmacienMiddleware");

const User = require("../models/user");
const Medecin = require("../models/medecin");
const Pharmacien = require("../models/pharmacien");
const mongoose = require("mongoose");
const appointmentSchema = require("../models/appointment");

const auth = express.Router();

//SignUp
auth.post("/api/signup", async (req, res) => {
    try {
        const {
            name,
            email,
            password,
            idn,
            wilaya,
            daira,
            telephone} = req.body;

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res
                .status(400)
                .json({ msg: "User with same email already exists!" });
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new User({
            name,
            email,
            password: hashedPassword,
            idn,
            wilaya,
            daira,
            // address,
            telephone
        });

        user = await user.save();
        const token = jwt.sign({ id: user._id }, "passwordKey");
        res.status(200).json({user,"token":token});
    } catch (e) {
        res.status(500).json({ error: e.message });
        console.log(e.message);
    }
});


// Sign In Route
auth.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) {
            return res
                .status(400)
                .json({ msg: "User with this email does not exist!" });
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect password." });
        }

        const token = jwt.sign({ id: user._id }, "passwordKey");
        console.log(token)
        res.json({ token, ...user._doc });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

auth.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);

        const user = await User.findById(verified.id);
        if (!user) return res.json(false);
        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// get user data
auth.get("/", authMiddleware, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
});


auth.get("/api/showMedecin/:wilaya/:daira", authMiddleware, async (req, res) => {
    try {
        const wilaya = req.params.wilaya;
        const daira = req.params.daira;
        const medecins = await Medecin.find({$and:[
                {wilaya : {$eq:wilaya}},
                {daira : {$eq : daira}}
            ]});
        res.json(medecins);
    } catch (e) {
        res.status(500).json({error: e.message},);
    }
});

auth.get("/api/showMedecin",authMiddleware, async (req, res) => {
    try {
        const medecins = await Medecin.find({});
        res.json(medecins);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});



//new =======================================================================
auth.get("/api/showUser",medecinMiddleware, async (req, res) => {
    try {
        const users = await User.find({});
        res.json(users);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//new =======================================================================
// create a get request to search medecins and get them
// /api/medecins/search/i
auth.get("/api/users/search/:name", medecinMiddleware, async (req, res) => {
    try {
        const users = await User.find({
            name: { $regex: req.params.name , $options: "i" },
        });

        res.json(users);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


auth.get("/api/showPharmacien/:wilaya/:daira", authMiddleware, async (req, res) => {
    try {
        const wilaya = req.params.wilaya;
        const daira = req.params.daira;
        const pharmaciens = await Pharmacien.find({$and:[
                {wilaya : {$eq:wilaya}},
                {daira : {$eq : daira}}
            ]});
        res.json(pharmaciens);
    } catch (e) {
        res.status(500).json({error: e.message},);
    }
});


auth.get("/api/showUser_Pharmacien",pharmacienMiddleware, async (req, res) => {
    try {
        const pharmaciens = await Pharmacien.find({});
        res.json(pharmaciens);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

const Appointment = mongoose.model("Appointment",appointmentSchema);
auth.get('/doctors/:doctorId', async (req, res) => {

    try {
        const { doctorId } = req.params;

        // Find appointments with the specified doctorId
        const appointments = await Appointment.find({ doctorId });

        // Get the userIds from the appointments
        const userIds = appointments.map(appointment => appointment.userId);

        // Find the users with the specified userIds
        const users = await User.find({ _id: { $in: userIds } });

        res.json(users);
    } catch (error) {
        console.error('Error fetching users:', error);
        res.status(500).json({ error: 'An error occurred' });
    }
});

// PUT /api/users/:userId/block
auth.put('/users/:userId/block', async (req, res) => {
    try {
        const { userId } = req.params;

        // Find the user by userId
        const user = await User.findById(userId);

        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        // console.log('userBlocked'+user.isBlocked);
        // Block the user by updating the necessary fields
        if(user.isBlocked == true){
            user.isBlocked = false;
        }else{
            user.isBlocked = true;
        }

        // Save the changes to the user
        await user.save();

        res.json({ message: 'User blocked successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
});




auth.put('/doctors/:doctorId/block', async (req, res) => {
    try {
        const { doctorId } = req.params;
        // console.log('doctor id = '+doctorId);
        // Find the user by userId
        const doctor = await Medecin.findById(doctorId);
        // console.log('doctor = '+doctor)

        if (!doctor) {
            return res.status(404).json({ message: 'User not found' });
        }
        // print('doctor isblocked'+);

        // Block the user by updating the necessary fields
        if(doctor.isBlocked == true){
            doctor.isBlocked = false;
            // console.log('doctor unblocked'+doctor.isBlocked);
        }else{
            doctor.isBlocked = true;
            // console.log('doctor blocked'+doctor.isBlocked);

        }

        // Save the changes to the user
        await doctor.save();

        res.json({ message: 'User blocked successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
});








module.exports = auth;