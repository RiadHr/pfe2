import 'package:flutter/material.dart';
import 'package:pfe2/features/notification/screen/notification_medecin.dart';
import 'package:pfe2/features/notification/screen/notification_screen.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/icon_container.dart';
import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../../appointment/screen/appointment_medecin_screen.dart';
import '../../auth/screens/auth_type.dart';
import 'home_screen.dart';
import 'home_screen_medecin.dart';

class BottomBarMedecin extends StatefulWidget {
  static const String routeName = '/actual-home-medecin';
  const BottomBarMedecin({Key? key}) : super(key: key);

  @override
  State<BottomBarMedecin> createState() => _BottomBarMedecinState();
}

class _BottomBarMedecinState extends State<BottomBarMedecin> {
  int _page = 0;
  double bottomBarWidth = 60;

  List<Widget> pages = [
    const HomeScreenMedecin(),
    const NotificationsMedecinScreen(),
    AppointmentMedecinScreen(),
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
        // iconSize: 20,
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
                iconD: Icons.notifications,
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
                pageNumber: 2),
            label: '',
          ),
        ],
      ),
    );
  }
}
