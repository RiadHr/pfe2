import 'package:flutter/material.dart';
import 'package:pfe2/features/notification/service/notification_service.dart';
import 'package:pfe2/models/notification.dart';
import 'package:provider/provider.dart';
import '../../../constants/global_variables.dart';
import '../../../providers/medecin_provider.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/services/auth_service_medecin.dart';
import '../../home/widget/loader.dart';
import '../../user/screens/user_detail_screen.dart';

class NotificationsMedecinScreen extends StatefulWidget {
  static const String routeName = '/notification_medecin_screen';
  const NotificationsMedecinScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsMedecinScreen> createState() =>
      _NotificationsMedecinScreenState();
}

class _NotificationsMedecinScreenState
    extends State<NotificationsMedecinScreen> {
  final AuthService authService = AuthService();
  final NotificationsService notificationsService = NotificationsService();
  List<Notifications>? notifications = [];

  @override
  void initState() {
    super.initState();
    fetchAllNotification();
  }

  fetchAllNotification() async {
    notifications =
        (await notificationsService.fetchAllNotificationssByDoctor(context))
            .cast<Notifications>();
    setState(() {});
  }

  Color defaultColor = GlobalVariables.firstColor;
  @override
  Widget build(BuildContext context) {
    return notifications == null
        ? const Loader()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    color: GlobalVariables.firstColor,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120,
                      height: 55,
                      child: Image(
                        image: AssetImage('images/tabibi.png'),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(defaultColor)),
                      onPressed: () {
                        setState(() {
                          defaultColor =
                              defaultColor != GlobalVariables.secondaryColor
                                  ? GlobalVariables.secondaryColor
                                  : GlobalVariables.firstColor;
                          authService.logOut(context);
                        });
                      },
                      child: Text(
                        'Se déconnecter',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: ListView.builder(
              itemCount: notifications!.length,
              itemBuilder: (context, index) {
                final notificationsData = notifications![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      UserDetailScreen.routeName,
                      arguments: notifications![index],
                    );
                  },
                  child: Container(
                    decoration: kItemListDecoration,
                    height: 100,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          // decoration: BoxDecoration(
                          //     border: Border.all(
                          //         width: 2,
                          //         style: BorderStyle.solid,
                          //         color: Colors.black),
                          //     ),
                          width: 80,
                          height: 80,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(right: 40),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.notifications,
                              color: Colors.grey,
                              size: 60,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${notificationsData.doctorName}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              // overflow: TextOverflow.ellipsis,
                              // maxLines: 2,
                            ),
                            Text('${notificationsData.userName}'),
                            Text(
                                '${notificationsData.time} ${notificationsData.dateTime}')
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
