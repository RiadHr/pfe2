import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/medecin.dart';
import '../../../models/pharmacien.dart';
import '../../../providers/medecin_provider.dart';
import '../../admin/screen/block_screen.dart';
import '../../home/screens/bottom_bar.dart';
import '../../home/screens/home_screen.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';
import '../screens/auth_type.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String idn,
    required String wilaya,
    required String daira,
    required String telephone,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        idn: idn,
        // address: address,
        wilaya: wilaya,
        daira: daira,
        telephone: telephone,
        token: '',
        type: '',
        // cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(res.statusCode);
      print(res.body);
      //I'm here
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
                (route) => false,
          );
        },
      );
    } catch (e) {

      showSnackBar(context, e.toString());
    }
  }


  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
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
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          await prefs.setString('wilaya', Provider.of<UserProvider>(context, listen: false).user.wilaya);
          await prefs.setString('daira', Provider.of<UserProvider>(context, listen: false).user.daira);
          print(jsonDecode(res.body)['isBlocked']);
          if(jsonDecode(res.body)['isBlocked'] == true){
            Navigator.pushNamedAndRemoveUntil(context, BlockScreen.routeName,
                (route) => false
            );
          }else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomBar.routeName,
                  (route) => false,
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData(
      BuildContext context,
      ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  //display all the medecins
  Future<List<Medecin>> fetchAllMedecins(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? wilaya  = prefs.getString('wilaya');
    final String? daira  = prefs.getString('daira');
    print('wilaya = $wilaya daira = $daira');

    List<Medecin> medecinList = [];
    try {
      http.Response res =
      await http.get(Uri.parse('$uri/api/showMedecin/$wilaya/$daira'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      print('medecinList$medecinList');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            medecinList.add(
              Medecin.fromJson(
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
    return medecinList;
  }



  //fetch all medecin
  Future<List<Medecin>> fetchMedecins(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Medecin> medecinList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response res =
      await http.get(Uri.parse('$uri/api/showMedecin'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            medecinList.add(
              Medecin.fromJson(
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
    return medecinList;
  }

  //display all the users
  Future<List<User>> fetchUsers(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<User> userList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response res =
      await http.get(Uri.parse('$uri/api/showUser'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            userList.add(
              User.fromJson(
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
    return userList;
  }

  //display all the users
  Future<List<User>> fetchAllUsers(BuildContext context) async {
    final medecinProvider = Provider.of<MedecinProvider>(context, listen: false);
    List<User> userList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String doctorId = medecinProvider.medecin.id;
      print(medecinProvider.medecin.id);

      String? token = prefs.getString('x-auth-token');
      http.Response res =
      await http.get(Uri.parse('$uri/doctors/$doctorId'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });

      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            userList.add(
              User.fromJson(
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
    return userList;
  }


  //Logout function
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthType.routeName,
            (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }



  Future<List<Pharmacien>> fetchAllPharmaciens(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? wilaya  = prefs.getString('wilaya');
    final String? daira  = prefs.getString('daira');


    List<Pharmacien> pharmacienList = [];
    try {
      http.Response res =
      await http.get(Uri.parse('$uri/api/showPharmacien/$wilaya/$daira'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            pharmacienList.add(
              Pharmacien.fromJson(
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
    return pharmacienList;
  }
}
