import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pfe2/models/notification.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../providers/medecin_provider.dart';
import '../../../providers/user_provider.dart';
import 'package:http/http.dart' as http;

class NotificationsService {

  //create notification from the booking screen
  Future<void> saveNotifications(userId, doctorId, dateTime, doctorName,
      userName,
      time) async {
    Notifications notification = Notifications(
        id: '',
        userId: userId,
        doctorId: doctorId,
        dateTime: dateTime,
        doctorName: doctorName,
        userName: userName,
        time: time
    );

    final url = Uri.parse('$uri/api/notifications');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = notification.toJson();

    print(body);

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.statusCode);

    if (response.statusCode == 201) {
      print('Notifications created successfully');
    } else {
      throw Exception('Failed to create notification');
    }
  }

  //display notification by doctor id
  Future<List<Notifications>> fetchAllNotificationssByUserId(
      BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? idUser = userProvider.user.id;
    // print('$idUser');


    List<Notifications> notificationList = [];
    try {
      http.Response res =
      await http.get(
          Uri.parse('$uri/api/notificationsByUser/$idUser'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });


      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            notificationList.add(
              Notifications.fromJson(
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
    return notificationList;
  }


  //display notification by doctorId
  Future<List<Notifications>> fetchAllNotificationssByDoctor(
      BuildContext context) async {
    final medecinProvider = Provider.of<MedecinProvider>(
        context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? idDoctor = medecinProvider.medecin.id;
    // print('$idUser');


    List<Notifications> notificationList = [];
    try {
      http.Response res =
      await http.get(
          Uri.parse('$uri/api/notificationsByDoctor/$idDoctor'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': medecinProvider.medecin.token,
      });


      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            notificationList.add(
              Notifications.fromJson(
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
    return notificationList;
  }
}