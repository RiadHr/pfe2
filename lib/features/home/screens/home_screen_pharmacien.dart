import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/global_variables.dart';
import '../../../models/user.dart';
import '../../../providers/medecin_provider.dart';
import '../../../providers/user_provider.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/services/auth_service_medecin.dart';
import '../../user/screens/user_detail_screen.dart';
import '../widget/loader.dart';

class HomeScreenPharmacien extends StatefulWidget {
  static const String routeName = '/home-medecin';
  const HomeScreenPharmacien({Key? key}) : super(key: key);

  @override
  State<HomeScreenPharmacien> createState() => _HomeScreenPharmacienState();
}

class _HomeScreenPharmacienState extends State<HomeScreenPharmacien> {
  final AuthService authService = AuthService();
  final AuthServiceMedecin authServiceMedecin = AuthServiceMedecin();
  List<User>? users = [];

  @override
  void initState() {
    super.initState();
    fetchAllUser();
  }

  fetchAllUser() async {
    users = await authService.fetchUsers(context);
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
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              Icons.account_circle,
                              color: Colors.grey,
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
