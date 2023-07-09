import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pfe2/features/home/screens/pharmacien_screen.dart';
import 'package:pfe2/features/notification/screen/notification_screen.dart';

import 'package:provider/provider.dart';
import '../../../common/widgets/icon_container.dart';
import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../../appointment/screen/appointment_screen.dart';
import 'home_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 60;
  String specialite = GlobalVariables.specialite[0];

  List<Widget> pages = [
    const HomeScreen(),
    const PharmacienScreen(),
    AppointmentScreen(),
    const NotificationsScreen()
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
        type: BottomNavigationBarType.fixed,
        // landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        currentIndex: _page,
        backgroundColor: GlobalVariables.fourthColor,
        // iconSize: 25,
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
                iconD: FontAwesomeIcons.solidMoon,
                page: _page,
                bottomBarWidth: bottomBarWidth,
                pageNumber: 1,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconContainer(
                iconD: Icons.calendar_month,
                page: _page,
                bottomBarWidth: bottomBarWidth,
                pageNumber: 2),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconContainer(
                iconD: Icons.notifications,
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
