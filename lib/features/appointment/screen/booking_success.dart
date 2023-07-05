import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../providers/medecin_provider.dart';
import '../../../providers/user_provider.dart';
import '../../home/screens/bottom_bar.dart';
import '../../home/screens/bottom_bar_medecin.dart';
import '../widget/button.dart';

class AppointmentBooked extends StatelessWidget {
  static const String routeName = '/reservation_success';
  const AppointmentBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    final medecinProvider = Provider.of<MedecinProvider>(context,listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Lottie.asset('images/success.json'),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Réservé avec succès',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            //back to home page
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Button(
                width: double.infinity,
                title: 'Retour à la page d\'accueil',
                onPressed: () {

                  if(userProvider != null) {
                    Navigator.pushNamed(context, BottomBar.routeName);
                  }else if(medecinProvider != null){
                    Navigator.pushNamed(context, BottomBarMedecin.routeName);
                  }
                },
                disable: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
