import 'package:flutter/material.dart';
import 'package:pfe2/features/appointment/screen/booking_medecin_screen.dart';
import 'package:pfe2/features/home/screens/bottom_bar_pharmacien.dart';
import 'package:pfe2/features/notification/screen/notification_screen.dart';
import 'package:pfe2/models/appointment.dart';
import 'features/admin/screen/admin_screen.dart';
import 'features/admin/screen/block_screen.dart';
import 'features/admin/screen/home_screen_admin.dart';
import 'features/admin/screen/home_screen_med_admin.dart';
import 'features/appointment/screen/appointment_medecin_screen.dart';
import 'features/appointment/screen/appointment_screen.dart';
import 'features/appointment/screen/booking_screen.dart';
import 'features/appointment/screen/booking_success.dart';
import 'features/auth/screens/auth_screen_medecin.dart';
import 'features/auth/screens/auth_screen_patient.dart';
import 'features/auth/screens/auth_screen_pharmacien.dart';
import 'features/auth/screens/auth_type.dart';
import 'features/home/screens/bottom_bar.dart';
import 'features/home/screens/bottom_bar_medecin.dart';
import 'features/home/screens/home_screen.dart';
import 'features/home/screens/home_screen_medecin.dart';
import 'features/home/screens/medecin_specialite_screen.dart';
import 'features/home/screens/pharmacien_screen.dart';
import 'features/medecin/screens/medecin_detail_screen.dart';
import 'features/pharmacien/screen/pharmacien_detail_screen.dart';
import 'features/search/screens/search_screen.dart';
import 'features/search/screens/search_screen_user.dart';
import 'features/user/screens/user_detail_screen.dart';
import 'models/medecin.dart';
import 'models/pharmacien.dart';
import 'models/user.dart';

Route<dynamic> generatedRoute(RouteSettings routeSettings,BuildContext context) {
  switch (routeSettings.name) {
    case AuthScreenPatient.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreenPatient(),
      );

    case AuthScreenMedecin.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreenMedecin(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case HomeScreenMedecin.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreenMedecin(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );

    case BottomBarMedecin.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBarMedecin(),
      );

    case AuthScreenPharmacien.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreenPharmacien(),
      );

    case AuthType.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthType(),
      );

    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AdminScreen(),
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as Map<String,String>;
      print('search query $searchQuery');
      // final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      // final String query = arguments['query'];
      // final String specialite = arguments['specialite'];
      // print('specialite $specialite , query $query');
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery['query'],
          specailite: searchQuery['specialite'],
        ),
      );

    case SearchScreenUser.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreenUser(
          searchQuery: searchQuery,
        ),
      );

    case MedecinDetailScreen.routeName:
      var medecin = routeSettings.arguments as Medecin;
      print('medecin = $medecin');
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => MedecinDetailScreen(
          medecin: medecin,
        ),
      );

    case PharmacienDetailScreen.routeName:
      var pharmacien = routeSettings.arguments as Pharmacien;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => PharmacienDetailScreen(
          pharmacien: pharmacien,
        ),
      );

    case UserDetailScreen.routeName:
      var user = routeSettings.arguments as User;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => UserDetailScreen(
          user: user,
        ),
      );

    case MedecinSpecialiteScreen.routeName:
      var specialite = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => MedecinSpecialiteScreen(
          specialite: specialite,
        ),
      );

    case AppointmentScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AppointmentScreen(),
      );

    case BookingScreen.routeName:
      var medecin = routeSettings.arguments as Medecin ;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BookingScreen(
            medecin:medecin as Medecin
        ),
      );

    case AppointmentBooked.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AppointmentBooked(),
      );

    case AppointmentMedecinScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AppointmentMedecinScreen(),
      );

    case PharmacienScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PharmacienScreen(),
      );

    case BlockScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  BlockScreen(),
      );

    case HomeAdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  HomeAdminScreen(),
      );

    case HomeScreenMedAdmin.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  HomeScreenMedAdmin(),
      );

    case NotificationsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => NotificationsScreen(),
      );

    case BottomBarPharmacien.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBarPharmacien(),
      );

    case BookingMedecinScreen.routeName:
      var appointment = routeSettings.arguments as Appointment ;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BookingMedecinScreen(
            appointment: appointment as Appointment,
        ),
      );


    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}