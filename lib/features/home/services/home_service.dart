import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import 'package:http/http.dart' as http;
import '../../../constants/utils.dart';
import '../../../models/medecin.dart';
import '../../../providers/user_provider.dart';

class HomeService{
  Future<List<Medecin>> fetchMedecinSpecialites({
    required BuildContext context,
    required String specialite,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Medecin> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/medecins?specialite=$specialite'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
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
    return productList;
  }



  Future<Medecin> fetchRecomendationMedecin({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Medecin medecin = Medecin(
      name: '',
      specialite:'' ,
      email: '',
      id: '',
      idMatricule: '' ,
      password: '',
      telephone: '',
      anciente: 0,
      token: '',
      wilaya: '',
      daira: '',
    );

    try {
      http.Response res =
      await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          medecin = Medecin.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return medecin;
  }
}

