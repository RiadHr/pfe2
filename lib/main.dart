import 'package:flutter/material.dart';
import 'package:pfe2/providers/appointment_provider.dart';
import 'package:pfe2/providers/medecin_provider.dart';
import 'package:pfe2/providers/pharmacien_provider.dart';
import 'package:pfe2/providers/user_provider.dart';
import 'package:pfe2/router.dart';
import 'package:provider/provider.dart';

import 'features/admin/screen/admin_screen.dart';
import 'features/auth/screens/auth_type.dart';
import 'features/auth/services/auth_service.dart';
import 'features/home/screens/bottom_bar.dart';

void main(){
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MedecinProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PharmacienProvider(),
        ),
        // new ==================================================
        ChangeNotifierProvider(
            create: (context) => AppointmentProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context as BuildContext);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => generatedRoute(settings,context),
      home:  Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
          ? const BottomBar()
          : AdminScreen()
          :const AuthType(),
      title: 'Flutter Demo',
    );
  }
}