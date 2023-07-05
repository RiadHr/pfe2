const mongoose = require("mongoose");
const express = require("express");
const authRouterAppointment = express.Router();
const appointmentSchema = require('../models/appointment');
const Medecin = require("../models/medecin");
const User = require("../models/user");

const Appointment = mongoose.model("Appointment",appointmentSchema);


// Create an appointment
authRouterAppointment.post('/api/appointments', async (req, res) => {
    try {
        const { userId, doctorId, dateTime,status,doctorName,userName,time } = req.body;

        let appointment = new Appointment({
        userId,
        doctorId,
        dateTime,
        status,
        doctorName,
        userName,
        time
        });
        const savedAppointment = await appointment.save();
        console.log(appointment);

        res.status(201).json(savedAppointment);
    }
    catch (error) {
        console.error('Failed to create appointment', error);
        res.status(500).json({ error: error.message });
    }
});


// Retrieve all appointments
authRouterAppointment.get('/api/appointments', async (req, res) => {
    try {
        let appointments= await Appointment.find();
        res.json(appointments);
        } catch (error) {
        console.error('Failed to retrieve appointments', error);
        res.status(500).json({ error: 'Failed to retrieve appointments' });
    }
});


// Retrieve a specific appointment
authRouterAppointment.get('/api/appointmentsByUser/:id', async (req, res) =>
{
    try {
        // console.log(req);
        const appointment = await Appointment.find({'userId':req.params.id});
        // console.log(appointment);
        if (!appointment) {
            return res.status(404).json({error: 'Appointment not found'});
        }
        res.json(appointment);
    } catch (error){
        console.error('Failed to retrieve appointments', error);
        res.status(500).json({ error: 'Failed to retrieve appointments' });
    }
});


// Retrieve a specific appointment
authRouterAppointment.get('/api/appointmentsByDoctor/:id', async (req, res) =>
{
    try {
        const appointment = await Appointment.find({'doctorId':req.params.id});
        if (!appointment) {
            return res.status(404).json({error: 'Appointment not found'});
        }
        res.json(appointment);
    } catch (error){
        console.error('Failed to retrieve appointments', error);
        res.status(500).json({ error: 'Failed to retrieve appointments' });
    }
});

// PUT route to update the current appointment for a doctor
authRouterAppointment.patch('/appointments/:appointmentId/:status', async (req, res) => {
    const appointmentId = req.params.appointmentId;
    const newStatus = req.params.status;

    try {
        // Find the appointment by appointmentId
        const appointment = await Appointment.findById(appointmentId);
        console.log('appointment :'+appointment);

        if (!appointment) {
            return res.status(404).json({ error: 'Appointment not found' });
        }

        // Update the appointment status
        appointment.status = newStatus;
        console.log('status'+newStatus);
        // Save the updated appointment
        console.log(appointment);
        await appointment.save();

        res.json({ message: 'Appointment status updated successfully' });
    } catch (error) {
        res.status(500).json({ error: 'An error occurred while updating appointment status' });
    }
});


// PUT route to update the appointment date for a doctor
authRouterAppointment.patch('/appointments/:appointmentId/:newdateTime', async (req, res) => {
    const appointmentId = req.params.appointmentId;
    const updatedDateTime = req.params.dateTime;
    print('date'+updatedDateTime);
    try {
        // Find the appointment by appointmentId
        const appointment = await Appointment.findById(appointmentId);
        print('appoitment'+appointment);
        if (!appointment) {
            return res.status(404).json({ error: 'Appointment not found' });
        }

        // Update the appointment date
        appointment.dateTime = updatedDateTime;
        appointment.updatedDateTime = new Date();

        // Save the updated appointment
        await appointment.save();

        res.json({ message: 'Appointment date updated successfully' });
    } catch (error) {
        res.status(500).json({ error: 'An error occurred while updating appointment date' });
    }
});







module.exports = authRouterAppointment;