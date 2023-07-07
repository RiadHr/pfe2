import 'package:flutter/material.dart';
import 'package:pfe2/features/pharmacien/screen/pharmacien_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/star.dart';
import '../../../constants/global_variables.dart';
import '../../../models/pharmacien.dart';
import '../../../providers/user_provider.dart';
import '../../auth/screens/auth_screen_patient.dart';
import '../../auth/services/auth_service.dart';
import '../../home/widget/Specialite.dart';
import '../../home/widget/loader.dart';
import '../../search/screens/search_screen.dart';
import '../../pharmacien/widget/pharmacien_item.dart';

class HomeAdminPhaScreen extends StatefulWidget {
  static const String routeName = '/home-screen-admin';
  const HomeAdminPhaScreen({Key? key}) : super(key: key);

  @override
  State<HomeAdminPhaScreen> createState() => _HomeAdminPhaScreenState();
}

class _HomeAdminPhaScreenState extends State<HomeAdminPhaScreen> {
  final AuthService authService = AuthService();
  List<Pharmacien> pharmaciens = [];

  double avgRating = 0;
  @override
  void initState() {
    super.initState();
    fetchAllMedecin();
  }

  fetchAllMedecin() async {
    pharmaciens = await authService.fetchpharmaciens(context);
    print(pharmaciens);
    setState(() {});
  }

  Color defaultColor = GlobalVariables.firstColor;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user.toJson();
    return pharmaciens == null
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
                    'Liste des Pharmacien',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: pharmaciens!.length,
                      itemBuilder: (context, index) {
                        final int i = index;
                        final pharmacienData = pharmaciens![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PharmacienDetailScreen.routeName,
                                arguments: pharmaciens![index]);
                          },
                          child: PharmacienItem(pharmacienData: pharmacienData),
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
