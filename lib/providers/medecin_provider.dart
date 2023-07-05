import 'package:flutter/material.dart';
import '../models/medecin.dart';

class MedecinProvider extends ChangeNotifier {
  Medecin _medecin = Medecin(
    id: '',
    idMatricule: '',
    name: '',
    email: '',
    password: '',
    specialite: '',
    wilaya: '',
    daira: '',
    telephone: '',
    anciente: 0,
    token: '',
    blockListed: false
  );

  Medecin get medecin => _medecin;

  void setMedecin(String medecin) {
    _medecin = Medecin.fromJson(medecin);
    notifyListeners();
  }

  void setMedecinFromModel(Medecin medecin) {
    _medecin = medecin;
    notifyListeners();
  }
}