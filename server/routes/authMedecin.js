const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");


const medecinMiddleware = require("../middlewares/medecinMiddleware");
const authMiddleware = require("../middlewares/auth");

const User = require("../models/user");
const Medecin = require("../models/medecin");

const authMedecin = express.Router();

//SignUp medecin
authMedecin.post("/api/signup_medecin", async (req, res) => {
    try {
        const {
            idMatricule,
            name,
            email,
            password,
            specialite,
            wilaya,
            daira,
            telephone,
            anciente} = req.body;

        const existingMedecin = await Medecin.findOne({ email });
        if (existingMedecin) {
            return res
                .status(400)
                .json({ msg: "Medecin with same email already exists!" });
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        let medecin = new Medecin({
            idMatricule,
            name,
            email,
            password: hashedPassword,
            specialite,
            wilaya,
            daira,
            telephone,
            anciente,
        });

        medecin = await medecin.save();
        const token = jwt.sign({ id: medecin._id }, "passwordKey");

        res.json({medecin,'token':token});
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


// Sign in medecin
authMedecin.post("/api/signin_medecin", async (req, res) => {
    try {
        const { email, password } = req.body;

        const medecin = await Medecin.findOne({ email });
        if (!medecin) {
            return res
                .status(400)
                .json({ msg: "Medecin with this email does not exist!" });
        }

        const isMatch = await bcryptjs.compare(password, medecin.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect password." });
        }

        const token = jwt.sign({ id: medecin._id }, "passwordKey");
        console.log(token);
        res.json({ token, ...medecin._doc });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//new ==================================================================================================================
authMedecin.post("/tokenMedecinIsValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);

        const medecin = await Medecin.findById(verified.id);
        if (!medecin) return res.json(false);
        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// new ==================================================================================================================
// get medecin data
authMedecin.get("/", medecinMiddleware, async (req, res) => {
    const medecin = await Medecin.findById(req.medecin);
    res.json({ ...medecin._doc, token: req.token });
});


// recherche des medecin par nom
// /api/medecins/search/i
authMedecin.get("/api/medecins/search/:param/:specialite", authMiddleware, async (req, res) => {
    try {
        const searchParam = req.params.param;
        const specialite = req.params.specialite;

        const medecins = await Medecin.find({
            $or: [
                { name: { $regex: searchParam, $options: "i" } },
                { address: { $regex: searchParam, $options: "i" } }
            ],
            specialite: { $regex: specialite, $options: "i" }
        });

        res.json(medecins);
    } catch (e) {
        res.status(500).json({ error: e.message });
        console.log(e.message);
    }
});




//affichage des medecin par specialite
authMedecin.get("/api/medecins/", authMiddleware, async (req, res) => {
    try {
        const medecins = await Medecin.find({ specialite: req.query.specialite });
        res.json(medecins);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


//rating des medecin par users
authMedecin.post("/api/rate-medecin", authMiddleware, async (req, res) => {
    try {
        const { id, rating } = req.body;
        let medecin = await Medecin.findById(id);

        //si le user a donner deja un rating et il veut donner un nouveaux rating
        for (let i = 0; i < medecin.ratings.length; i++) {
            if (medecin.ratings[i].userId == req.user) {
                medecin.ratings.splice(i, 1);
                break;
            }
        }

        const ratingSchema = {
            userId: req.user,
            rating,
        };

        medecin.ratings.push(ratingSchema);
        medecin = await medecin.save();
        res.json(medecin);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


authMedecin.put('/doctors/:doctorId/blacklist/:userId', async (req, res) => {
    try {
        const { doctorId, userId } = req.params;

        // Find the doctor by doctorId
        const doctor = await Medecin.findById(doctorId);
        if (!doctor) {
            return res.status(404).json({ error: 'Doctor not found' });
        }

        // Find the user by userId
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }

        // Add the user to the doctor's blacklist
        user.isBlacklisted.push(doctor.id);
        await user.save();

        // Set the user's blacklist status to true
        doctor.isBlacklisted.push(user.id);
        await doctor.save();

        res.json({ message: 'User blacklisted successfully' });
    } catch (error) {
        console.error('Error blacklisting user:', error);
        res.status(500).json({ error: 'An error occurred' });
    }
});








module.exports = authMedecin;

























// authMedecin.get("/api/medecins/search/:name", auth, async (req, res) => {
//     try {
//         const medecins = await Medecin.find({
//             name: { $regex: req.params.name , $options: "i" },
//
//         },);
//         res.json(medecins);
//     } catch (e) {
//         res.status(500).json({ error: e.message });
//         console.log(e.message)
//     }
//
// });

// try {
//     const { name, address } = req.query;
//
//     const searchQuery = {
//         $or: [
//             { name: { $regex: name, $options: "i" } },
//             { address: { $regex: address, $options: "i" } }
//         ]
//     };
//
//     const medecins = await Medecin.find(searchQuery);
//
//     res.json(medecins);
// } catch (e) {
//     res.status(500).json({ error: e.message });
//     console.log(e.message);
// }


// try {
//     const { name, address } = req.query;
//
//     const medecin = await Medecin.find({
//         name: { $regex: name, $options: "i" },
//         address: { $regex: address, $options: "i" },
//     });
//
//     res.json(medecin);
// } catch (e) {
//     res.status(500).json({ error: e.message });
// }