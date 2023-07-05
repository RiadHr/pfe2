import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../constants/global_variables.dart';
import '../../../models/user.dart';
import '../../../providers/medecin_provider.dart';
import '../../../providers/user_provider.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/services/auth_service_medecin.dart';
import '../../search/screens/search_screen_user.dart';
import '../../user/screens/user_detail_screen.dart';
import '../widget/loader.dart';

class HomeScreenMedecin extends StatefulWidget {
  static const String routeName = '/home-medecin';
  const HomeScreenMedecin({Key? key}) : super(key: key);

  @override
  State<HomeScreenMedecin> createState() => _HomeScreenMedecinState();
}

class _HomeScreenMedecinState extends State<HomeScreenMedecin> {
  final AuthService authService = AuthService();
  final AuthServiceMedecin authServiceMedecin = AuthServiceMedecin();
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
    users = await authService.fetchAllUsers(context);
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
            appBar:  PreferredSize(
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
                      style: ButtonStyle(backgroundColor:MaterialStateProperty.all(defaultColor)),
                      onPressed: (){
                        setState(() {
                          defaultColor = defaultColor != GlobalVariables.secondaryColor ? GlobalVariables.secondaryColor : GlobalVariables.firstColor ;
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

                        ElevatedButton(
                            onPressed: (){
                              authServiceMedecin.blacklistUser(doctor.id,userData.id);
                            },
                            child: Icon(
                              Icons.block
                            ),
                            style:  ElevatedButton.styleFrom(
                              primary: Colors.red,
                              elevation: 0,
                              fixedSize: Size.fromHeight(50),
                              shape: CircleBorder()
                            ),)
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}




// Expanded(
//   child: Container(
//     height: 42,
//     // margin: const EdgeInsets.only(left: 15),
//     child: Material(
//       borderRadius: BorderRadius.circular(7),
//       elevation: 1,
//       child: TextFormField(
//         onFieldSubmitted: navigateToSearchScreen,
//         decoration: InputDecoration(
//           prefixIcon: InkWell(
//             onTap: () {},
//             child: const Padding(
//               padding: EdgeInsets.only(
//                 left: 6,
//               ),
//               child: Icon(
//                 Icons.search,
//                 color: Colors.black,
//                 size: 23,
//               ),
//             ),
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding: const EdgeInsets.only(top: 10),
//           border: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(7),
//             ),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(7),
//             ),
//             borderSide: BorderSide(
//               color: Colors.black38,
//               width: 1,
//             ),
//           ),
//           hintText: 'rechercher par nom ou par localisation ',
//           hintStyle: const TextStyle(
//             fontWeight: FontWeight.w500,
//             fontSize: 17,
//           ),
//         ),
//       ),
//     ),
//   ),
// ),
// Container(
//   color: Colors.transparent,
//   height: 42,
//   margin: const EdgeInsets.symmetric(horizontal: 10),
//   child: const Icon(
//     Icons.notifications,
//     color: GlobalVariables.firstColor,
//     size: 25,
//   ),
// ),