import 'package:flutter/material.dart';

import '../models/appointment.dart';


class AppointmentProvider extends ChangeNotifier {
  Appointment _appointment = Appointment(
       id: '',
       doctorId: '',
       userId: '',
       dateTime :DateTime.now(),
       status:'',
       doctorName : '',
       userName: '',
       time: ''
  );

  Appointment get appointment => _appointment;

  void setAppointment(String appointment) {
    _appointment = Appointment.fromJson(appointment);
    notifyListeners();
  }

  void changeAppointmentStatus(String status){
    _appointment.status = status;
    notifyListeners();
  }

  void setAppointmentFromModel(Appointment appointment) {
    _appointment = appointment;
    notifyListeners();
  }
}