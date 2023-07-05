

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../models/medecin.dart';
import '../../../providers/user_provider.dart';

class MedecinItem extends StatelessWidget {
  const MedecinItem({
    super.key,
    required this.medecinData,
  });

  final Medecin medecinData;

  @override
  Widget build(BuildContext context) {

    // AdminService adminService = AdminService();
    final user  = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: kItemListDecoration,
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              // border: Border.all(
              //     width: 2,
              //     style: BorderStyle.solid,
              //     color: Colors.black),
            ),
            width: 80,
            height: 80,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(right: 40),
            child: CircleAvatar(
              // backgroundColor: Colors.white,
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 60,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Dr ${medecinData.name}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                // overflow: TextOverflow.ellipsis,
                // maxLines: 2,
              ),
              Text('${medecinData.specialite}'),
              Text('${medecinData.wilaya}'),

            ],
          ),
        ],
      ),
    );
  }
}