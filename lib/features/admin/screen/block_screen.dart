import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';
import '../../auth/screens/auth_type.dart';
import '../../auth/services/auth_service.dart';

class BlockScreen extends StatefulWidget {
  static const String routeName = '/block_screen';
  const BlockScreen({super.key});

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  AuthService authService = AuthService();
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
              const SizedBox(width:10,),
              Container(
                width: 120,
                height: 55,
                child: const Image(
                  image: AssetImage('images/tabibi.png'),
                ),
              ),
              const SizedBox(
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
                child: const Text(
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/blockscreen.jpg'),
            const Text(
              'vous etes blocker par l admin',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kDebugMode ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
            const SizedBox(height: 12),

          ],
        ),
      ),
    );
  }
}
