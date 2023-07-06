import 'package:flutter/material.dart';
import '../../../common/widgets/icon_container.dart';
import '../../../constants/global_variables.dart';
import '../../auth/screens/auth_type.dart';
import 'home_screen_pharmacien.dart';

class BottomBarPharmacien extends StatefulWidget {
  static const String routeName = '/actual-home-pharmacien';
  const BottomBarPharmacien({Key? key}) : super(key: key);

  @override
  State<BottomBarPharmacien> createState() => _BottomBarPharmacienState();
}

class _BottomBarPharmacienState extends State<BottomBarPharmacien> {
  int _page = 0;
  double bottomBarWidth = 60;

  List<Widget> pages = [
    const HomeScreenPharmacien(),
    const AuthType(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: GlobalVariables.fourthColor,
        iconSize: 20,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: IconContainer(
                iconD: Icons.home,
                page: _page,
                bottomBarWidth: bottomBarWidth,
                pageNumber: 0),
            label: '',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: IconContainer(
                iconD: Icons.account_circle,
                page: _page,
                bottomBarWidth: bottomBarWidth,
                pageNumber: 1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconContainer(
                iconD: Icons.calendar_month,
                page: _page,
                bottomBarWidth: bottomBarWidth,
                pageNumber: 3),
            label: '',
          ),
        ],
      ),
    );
  }
}