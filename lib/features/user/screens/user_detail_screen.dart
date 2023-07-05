import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/user.dart';




class UserDetailScreen extends StatelessWidget {
  static const String routeName = '/user-detail';
  final User user;

  const UserDetailScreen({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('detail user'),),
    );
  }
}