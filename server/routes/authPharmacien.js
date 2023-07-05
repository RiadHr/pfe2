const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

// const auth = require("../middlewares/auth");

const authPharmacien = express.Router();
const pharmacienMiddleware = require("../middlewares/pharmacienMiddleware");
const authMiddleware = require("../middlewares/auth");
const Pharmacien = require("../models/pharmacien");


//SignUp
authPharmacien.post("/api/signup_pharmacien", async (req, res) => {
    try {
        const {
            idMatricule,
            name,
            email,
            password,
            wilaya,
            daira,
            telephone,
            anciente} = req.body;

        const existingPharmacien = await Pharmacien.findOne({ email });
        if (existingPharmacien) {
            return res
                .status(400)
                .json({ msg: "Pharmacien with same email already exists!" });
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        let pharmacien = new Pharmacien({
            idMatricule,
            name,
            email,
            password: hashedPassword,
            wilaya,
            daira,
            telephone,
            anciente,
        });

        pharmacien = await pharmacien.save();
        const token = jwt.sign({ id: pharmacien._id }, "passwordKey");

        res.json({pharmacien,'token':token});
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


// Sign In Route
authPharmacien.post("/api/signin_pharmacien", async (req, res) => {
    try {
        const { email, password } = req.body;

        const pharmacien = await Pharmacien.findOne({ email });
        if (!pharmacien) {
            return res
                .status(400)
                .json({ msg: "Pharmacien with this email does not exist!" });
        }

        const isMatch = await bcryptjs.compare(password, pharmacien.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect password." });
        }

        const token = jwt.sign({ id: pharmacien._id }, "passwordKey");
        console.log(token);
        res.json({ token, ...pharmacien._doc });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


//new ==================================================================================================================
authPharmacien.post("/tokenPharmacienIsValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);

        const pharmacien = await Pharmacien.findById(verified.id);
        if (!pharmacien) return res.json(false);
        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// new ==================================================================================================================
// get pharmacien data
authPharmacien.get("/", pharmacienMiddleware, async (req, res) => {
    const pharmacien = await Pharmacien.findById(req.pharmacien);
    res.json({ ...pharmacien._doc, token: req.token });
});


authPharmacien.get("/api/pharmaciens/search/:param", authMiddleware, async (req, res) => {
    try {
        const searchParam = req.params.param;

        const pharmaciens = await Pharmacien.find({
            $or: [
                { name: { $regex: searchParam, $options: "i" } },
                { address: { $regex: searchParam, $options: "i" } }
            ]
        });
        console.log(pharmaciens);
        res.json(pharmaciens);

    } catch (e) {
        res.status(500).json({ error: e.message });
        console.log(e.message);
    }
});


authPharmacien.post("/api/rate-pharmacien", authMiddleware, async (req, res) => {
    try {
        const { id, rating } = req.body;
        let pharmacien = await Pharmacien.findById(id);

        //si le user a donner deja un rating et il veut donner un nouveaux rating
        for (let i = 0; i < pharmacien.ratings.length; i++) {
            if (pharmacien.ratings[i].userId == req.user) {
                pharmacien.ratings.splice(i, 1);
                break;
            }
        }

        const ratingSchema = {
            userId: req.user,
            rating,
        };

        pharmacien.ratings.push(ratingSchema);
        pharmacien = await pharmacien.save();
        res.json(pharmacien);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});




module.exports = authPharmacien;