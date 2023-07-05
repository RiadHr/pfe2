import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/star.dart';
import '../../../constants/global_variables.dart';
import '../../../models/medecin.dart';
import '../../../providers/user_provider.dart';
import '../../auth/screens/auth_screen_patient.dart';
import '../../auth/services/auth_service.dart';
import '../../home/widget/Specialite.dart';
import '../../home/widget/loader.dart';
import '../../medecin/screens/medecin_detail_screen.dart';
import '../../search/screens/search_screen.dart';
import '../../medecin/widget/medecin_item.dart';

class HomeAdminScreen extends StatefulWidget {
  static const String routeName = '/home-screen-admin';
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  final AuthService authService = AuthService();
  List<Medecin> medecins = [];

  double avgRating = 0;
  @override
  void initState() {
    super.initState();
    fetchAllMedecin();
  }

  fetchAllMedecin() async {
    medecins = await authService.fetchMedecins(context);
    print(medecins);
    setState(() {});
  }

  Color defaultColor = GlobalVariables.firstColor;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user.toJson();
    return medecins == null
        ? const Loader()
        : Material(
            child: Scaffold(
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
              body: Column(
                children: [
                  Specialite(),
                  Text(
                    'Liste des Medecin',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: medecins!.length,
                      itemBuilder: (context, index) {
                        final int i = index;
                        final medecinData = medecins![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, MedecinDetailScreen.routeName,
                                arguments: medecins![index]);
                          },
                          child: MedecinItem(medecinData: medecinData),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

// Center(child:Text(user.toString(),),),
