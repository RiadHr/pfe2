import 'package:flutter/material.dart';
import 'package:pfe2/features/notification/service/notification_service.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../models/user.dart';
import '../../../providers/medecin_provider.dart';
import '../../../providers/user_provider.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/services/auth_service_medecin.dart';
import '../../home/widget/loader.dart';
import '../../search/screens/search_screen_user.dart';
import '../../user/screens/user_detail_screen.dart';

class NotificationsScreen extends StatefulWidget {
  static const String routeName = '/notification_screen';
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final AuthService authService = AuthService();
  final NotificationsService notificationsService = NotificationsService();
  List<User>? users = [];

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreenUser.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    fetchAllUser();
  }

  fetchAllUser() async {
    users = (await notificationsService.fetchAllNotificationssByUserId(context)).cast<User>();
    setState(() {});
  }

  Color defaultColor = GlobalVariables.firstColor;
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user.toJson();
    var doctor = Provider.of<MedecinProvider>(context).medecin;
    return users == null
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
              itemCount: users!.length,
              itemBuilder: (context, index) {
                final userData = users![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      UserDetailScreen.routeName,
                      arguments: users![index],
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
                              '${userData.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              // overflow: TextOverflow.ellipsis,
                              // maxLines: 2,
                            ),
                            Text('${userData.telephone}'),
                            Text('${userData.name}')
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
