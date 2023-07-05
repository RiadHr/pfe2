import 'package:flutter/material.dart';
import '../../../common/widgets/icon_container.dart';
import '../../../constants/global_variables.dart';
import '../../../models/medecin.dart';
import '../../auth/screens/auth_type.dart';
import '../../search/screens/search_screen.dart';
import '../../search/services/search_service.dart';
import 'home_screen_admin.dart';
import 'home_screen_med_admin.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-home';

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 60;
  double bottomBarBorderWidth = 5;
  List<Widget> pages = [
    HomeAdminScreen(),
    HomeScreenMedAdmin(),
    AuthType(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:
        pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: GlobalVariables.fourthColor,
        iconSize: 25,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: IconContainer(
                iconD: Icons.local_hospital,
                page: _page,
                bottomBarWidth: bottomBarWidth,
                pageNumber: 0),
            label: '',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: IconContainer(
                iconD: Icons.supervised_user_circle,
                page: _page,
                bottomBarWidth: bottomBarWidth,
                pageNumber: 1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconContainer(
                iconD: Icons.account_circle,
                page: _page,
                bottomBarWidth: bottomBarWidth,
                pageNumber: 2),
            label: '',
          ),
        ],
      ),
    );
  }
}
