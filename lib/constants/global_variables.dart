import 'package:flutter/material.dart';


String uri = 'http://192.168.1.12:3000';

class GlobalVariables {
  static const firstColor = Color.fromRGBO(41, 34, 139, 1);
  static const secondaryColor = Color.fromRGBO(225, 124, 122, 1);
  static const thirdColor = Color.fromRGBO(41, 34, 139, 0.3);
  static const fourthColor = Color.fromRGBO(255, 255, 255, 1);
  static const fifthColor = Color.fromRGBO(0, 0, 0, 1);

  static const List<String> specialite = [
    'Anapathologie',
    'Biologie',
    'Cardiologie',
    'Dermatologie',
    'Cherurgie-generale',
    'Gastro-entérologie',
    'Genycologie',
    'Médecine générale',
    'Medecine interne',
    'Neurologie',
    'Ophtalmologie',
    'ORL',
    'Pédiatrie',
    'Pnmeulogie',
    'Urologie',
    'Radiologie',
    'Reducation-orthopedie'
    'traumatologie'
  ];

  static const List<String> appointmentStatus = [
    'complet',
    'prochain',
    'annuler'
  ];


}

var kItemListDecoration = BoxDecoration(
  color: Colors.white,
  // border: Border.all(
  //     width: 2,
  //     style: BorderStyle.solid,
  //     color: Colors.black),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      // blurStyle: BlurStyle.outer,
      spreadRadius: 5,
      blurRadius: 7,
      offset: Offset(0, 3),
    ),
  ],
);

var kItemSpecialiteDecoration = BoxDecoration(
  color: GlobalVariables.secondaryColor,
  // border: Border.all(
  //     width: 2,
  //     style: BorderStyle.solid,
  //     color: Colors.black),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      // blurStyle: BlurStyle.outer,
      spreadRadius: 5,
      blurRadius: 7,
      offset: Offset(0, 3),
    ),
  ],
);




