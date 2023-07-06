import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../home/screens/bottom_bar_medecin.dart';
import '../../home/screens/bottom_bar_pharmacien.dart';
import '../../home/screens/home_screen.dart';
import '../../../models/pharmacien.dart';
import '../../../providers/pharmacien_provider.dart';


class AuthServicePharmacien {
  // sign up Pharmacien
  void signUpPharmacien({
    required BuildContext context,
    required String idMatricule,
    required String email,
    required String password,
    required String name,
    required String wilaya,
    required String daira,
    required String telephone,
    required int anciente
  }) async {
    try {
      Pharmacien pharmacien = Pharmacien(
          id: '',
          name: name,
          password: password,
          email: email,
          wilaya:wilaya,
          daira : daira,
          telephone: telephone,
          token: '',
          anciente: anciente,
          idMatricule: idMatricule
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup_pharmacien'),
        body: pharmacien.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.statusCode);
      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<PharmacienProvider>(context, listen: false).setPharmacien(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBarPharmacien.routeName,
                (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in medecin
  void signInPharmacien({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin_pharmacien'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<PharmacienProvider>(context, listen: false).setPharmacien(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBarPharmacien.routeName,
                (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // new ===========================================================================================
  void getPharmacienData(
      BuildContext context,
      ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenPharmacienIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response pharmacienRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var pharmacienProvider = Provider.of<PharmacienProvider>(context, listen: false);
        pharmacienProvider.setPharmacien(pharmacienRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
