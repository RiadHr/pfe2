import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';
import 'auth_screen_medecin.dart';
import 'auth_screen_patient.dart';
import 'auth_screen_pharmacien.dart';

class AuthType extends StatefulWidget {
  static const String routeName = 'authtype';
  const AuthType({Key? key}) : super(key: key);

  @override
  State<AuthType> createState() => _AuthTypeState();
}

Color defaultColor = GlobalVariables.firstColor;

class _AuthTypeState extends State<AuthType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ],
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width:250 ,
          height:300 ,
          child: Card(
            shadowColor: GlobalVariables.firstColor,
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            color: GlobalVariables.firstColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Authentification',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Builder(
                  builder: (context) {
                    return SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        onHover: (value) {},
                        style: ElevatedButton.styleFrom(
                          primary:
                              GlobalVariables.secondaryColor, // background color
                          shadowColor:
                              GlobalVariables.thirdColor, // elevation color
                          elevation: 5, // elevation of button
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AuthScreenPatient.routeName);
                        },
                        child: Text('Utilisateur'),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20,),
                Builder(
                  builder: (context) {
                    return SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              GlobalVariables.secondaryColor, // background color
                          shadowColor:
                              GlobalVariables.thirdColor, // elevation color
                          elevation: 5, // elevation of button
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AuthScreenMedecin.routeName);
                        },
                        child: Text('Medecin'),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20,),
                Builder(
                  builder: (context) {
                    return SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              GlobalVariables.secondaryColor, // background color
                          shadowColor:
                              GlobalVariables.thirdColor, // elevation color
                          elevation: 5, // elevation of button
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AuthScreenPharmacien.routeName);
                        },
                        child: Text('Pharmacien'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
