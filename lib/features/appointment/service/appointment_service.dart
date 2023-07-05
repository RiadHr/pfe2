import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import 'package:http/http.dart' as http;
import '../../../constants/utils.dart';
import '../../../models/appointment.dart';
import '../../../providers/medecin_provider.dart';
import '../../../providers/user_provider.dart';

class AppointmentService {

  //create appointment from the booking screen
  Future<void> saveAppointment(userId, doctorId, dateTime, doctorName, userName,
      status, time) async {
    Appointment appointment = Appointment(
        id: '',
        userId: userId,
        doctorId: doctorId,
        dateTime: dateTime,
        doctorName: doctorName,
        userName: userName,
        status: "prochain",
        time: time
    );

    final url = Uri.parse('$uri/api/appointments');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = appointment.toJson();

    print(body);

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.statusCode);

    if (response.statusCode == 201) {
      print('Appointment created successfully');
    } else {
      throw Exception('Failed to create appointment');
    }
  }


//   Future<List<Appointment>> fetchAllAppointments(BuildContext context) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//
//     List<Appointment> appointmentList = [];
//     try {
//       http.Response res =
//       await http.get(Uri.parse('$uri/api/appointments'), headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'x-auth-token': userProvider.user.token,
//       });
//
//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () {
//           for (int i = 0; i < jsonDecode(res.body).length; i++) {
//             appointmentList.add(
//               Appointment.fromJson(
//                 jsonEncode(
//                   jsonDecode(res.body)[i],
//                 ),
//               ),
//             );
//           }
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//     return appointmentList;
//   }
// }


  //display appointment by doctor id
  Future<List<Appointment>> fetchAllAppointmentsByUserId(
      BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? idUser = userProvider.user.id;
    // print('$idUser');


    List<Appointment> appointmentList = [];
    try {
      http.Response res =
      await http.get(
          Uri.parse('$uri/api/appointmentsByUser/$idUser'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });


      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            appointmentList.add(
              Appointment.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return appointmentList;
  }


  //display appointment by doctorId
  Future<List<Appointment>> fetchAllAppointmentsByDoctor(
      BuildContext context) async {
    final medecinProvider = Provider.of<MedecinProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? idDoctor = medecinProvider.medecin.id;
    // print('$idUser');


    List<Appointment> appointmentList = [];
    try {
      http.Response res =
      await http.get(
          Uri.parse('$uri/api/appointmentsByDoctor/$idDoctor'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': medecinProvider.medecin.token,
      });


      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            appointmentList.add(
              Appointment.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return appointmentList;
  }

  Future<void> updateAppointmentStatus(BuildContext context,String appointmentId, String status) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // Make an HTTP PUT request to the backend API
      final response = await http.patch(
        Uri.parse('$uri/appointments/$appointmentId/$status'),
        headers:  {'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,}
      );

      print('annuler le rendez-vous${response.body}');

      if (response.statusCode == 200) {
        print(true); // Success
      } else {
        print(false); // Error
      }
    }
    catch(e){
      print(e);
    }
  }

  Future<void> updateAppointmentDate(
      String appointmentId, DateTime newDateTime,BuildContext context) async {
    final medecinProvider = Provider.of<MedecinProvider>(context,listen: false);
    // final url = Uri.parse('$uri/appointments/$appointmentId/$newDateTime');


    try {
      final response = await http.patch(
          Uri.parse('$uri/appointments/$appointmentId/$newDateTime'),
          headers:  {'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': medecinProvider.medecin.token,}
      );
      // final response = await http.put(
      //   url,
      //   headers: headers,
      //   body: body,
      // );

      if (response.statusCode == 200) {
        print('Appointment date updated successfully');
      } else {
        throw Exception('Failed to update appointment date');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to update appointment date');
    }
  }
}