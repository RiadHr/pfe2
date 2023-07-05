const mongoose = require("mongoose");
const express = require("express");
const authRouterNotification = express.Router();
const notificationSchema = require('../models/notification');

const Notification = mongoose.model("Notification",notificationSchema);


// Create an notification
authRouterNotification.post('/api/notifications', async (req, res) => {
    try {
        const { userId, doctorId, dateTime,doctorName,userName,time } = req.body;

        let notification = new Notification({
            userId,
            doctorId,
            dateTime,
            doctorName,
            userName,
            time
        });
        const savedNotification = await notification.save();
        console.log(notification);

        res.status(201).json(savedNotification);
    }
    catch (error) {
        console.error('Failed to create notification', error);
        res.status(500).json({ error: error.message });
    }
});


// Retrieve a specific notification
authRouterNotification.get('/api/notificationsByUser/:id', async (req, res) =>
{
    try {
        // console.log(req);
        const notification = await Notification.find({'userId':req.params.id});
        // console.log(notification);
        if (!notification) {
            return res.status(404).json({error: 'Notification not found'});
        }
        res.json(notification);
    } catch (error){
        console.error('Failed to retrieve notifications', error);
        res.status(500).json({ error: 'Failed to retrieve notifications' });
    }
});


// Retrieve a specific notification
authRouterNotification.get('/api/notificationsByDoctor/:id', async (req, res) =>
{
    try {
        const notification = await Notification.find({'doctorId':req.params.id});
        if (!notification) {
            return res.status(404).json({error: 'Notification not found'});
        }
        res.json(notification);
    } catch (error){
        console.error('Failed to retrieve notifications', error);
        res.status(500).json({ error: 'Failed to retrieve notifications' });
    }
});


module.exports = authRouterNotification;