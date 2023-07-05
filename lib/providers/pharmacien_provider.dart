import 'package:flutter/cupertino.dart';

import '../models/pharmacien.dart';

class PharmacienProvider extends ChangeNotifier {
  Pharmacien _pharmacien = Pharmacien(
    id: '',
    idMatricule: '',
    name: '',
    email: '',
    password: '',
    wilaya: '',
    daira: '',
    telephone: '',
    token: '',
    anciente: 0
  );

  Pharmacien get pharmacien => _pharmacien;

  void setPharmacien(String pharmacien) {
    _pharmacien = Pharmacien.fromJson(pharmacien);
    notifyListeners();
  }

  void setPharmacienFromModel(Pharmacien pharmacien) {
    _pharmacien = pharmacien;
    notifyListeners();
  }
}