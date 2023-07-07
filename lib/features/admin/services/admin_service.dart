import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../../constants/global_variables.dart';

class AdminService{
  Future<void> blocklistUser( String userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final url = Uri.parse('$uri/users/$userId/block');

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
        body: json.encode({'userId':userId}),
      );

      if (response.statusCode == 200) {
        print('User blacklisted successfully');
      } else {
        print('${response.body}: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }



  Future<void> blocklistDoctor( String doctorId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final url = Uri.parse('$uri/doctors/$doctorId/block');

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
        body: json.encode({'doctorId':doctorId}),
      );

      if (response.statusCode == 200) {
        print(response.body);
        print('User blocklisted successfully');
      } else {
        print('${response.body}: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

}