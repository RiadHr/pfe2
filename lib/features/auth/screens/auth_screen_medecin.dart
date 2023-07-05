import 'package:dzair_data_usage/daira.dart';
import 'package:dzair_data_usage/dzair.dart';
import 'package:dzair_data_usage/langs.dart';
import 'package:dzair_data_usage/wilaya.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe2/features/auth/controllers/formController.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_datefield.dart';
import '../../../common/widgets/custom_passwordfield.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../../common/widgets/input_container.dart';
import '../../../constants/global_variables.dart';
import '../services/auth_service_medecin.dart';
import '../widgets/custom_form_field.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreenMedecin extends StatefulWidget {
  static const String routeName = 'auth-screen-medecin';
  const AuthScreenMedecin({super.key});

  @override
  State<AuthScreenMedecin> createState() => _AuthScreenMedecinState();
}

class _AuthScreenMedecinState extends State<AuthScreenMedecin> {
  Auth _auth = Auth.signin;
  String selectedSpecialite = GlobalVariables.specialite[0];
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthServiceMedecin authServiceMedecin = AuthServiceMedecin();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idMatriculeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specialiteController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _ancienteController = TextEditingController();
  String? selectedWilaya = Dzair().getWilayat()?.first?.getWilayaName(Language.FR);
  String? selectedDaira = Dzair().getDairat()?.first?.getDairaName(Language.FR);


  void signUpMedecin() {

    // print(_ancienteController.text);
    // print(DateTime.parse(_ancienteController.text).year);
    // print( DateTime.now().year);
    // print(DateTime.now().year - DateTime.parse(_ancienteController.text).year);
    authServiceMedecin.signUpMedecin(
      context: context,
      idMatricule: _idMatriculeController.text,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      specialite: selectedSpecialite,
      telephone: _telephoneController.text,
      wilaya:selectedWilaya ?? '',
      daira:selectedDaira ?? '',
      anciente:
      DateTime.now().year - DateTime.parse(_ancienteController.text).year,
      // address: _addressController.text,
    );

  }


  void signInMedecin() {
    authServiceMedecin.signInMedecin(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _specialiteController.dispose();
    _telephoneController.dispose();
  }

  DropdownButton getSpecialiteDropdown() {
    List<String> specialite = GlobalVariables.specialite;
    List<DropdownMenuItem<String>> dropdownList = [];

    specialite.forEach((item) {
      var dropitem = DropdownMenuItem(
        child: Text(item),
        value: item,
      );
      dropdownList.add(dropitem);
    });

    return DropdownButton(
      value: selectedSpecialite,
      items: dropdownList,
      onChanged: (value) {
        selectedSpecialite = value;
        setState(() {});
      },
    );
  }

  DropdownButton getWilayaDropdown() {
    List<Wilaya?>? wilayas = Dzair().getWilayat();
    List<DropdownMenuItem<String>> dropdownList = [];
    if (wilayas != null) {
      wilayas?.forEach((item) {
        String wilaya = item?.getWilayaName(Language.FR) ?? "null";
        var dropitem = DropdownMenuItem(
          child: Text(wilaya),
          value: wilaya,
        );
        dropdownList.add(dropitem);
      });
    }

    return DropdownButton(
      value: selectedWilaya,
      items: dropdownList,
      onChanged: (value) {
        selectedWilaya = value;
        setState(() {});
      },
    );
  }

  DropdownButton getDairaDropdown() {
    List<Daira?>? dairas = Dzair().getDairat();
    List<DropdownMenuItem<String>> dropdownList = [];
    if (dairas != null) {
      dairas.forEach((item) {
        String daira = item?.getDairaName(Language.FR) ?? "null";
        var dropitem = DropdownMenuItem(
          child: Text(daira),
          value: daira,
        );
        dropdownList.add(dropitem);
      });
    }

    return DropdownButton(
      style: TextStyle(backgroundColor: Colors.white, color: Colors.black),
      value: selectedDaira,
      items: dropdownList,

      onChanged: (value) {
        selectedDaira = value;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.fourthColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      topEnd: Radius.circular(10),
                    ),
                  ),
                  tileColor: GlobalVariables.firstColor,
                  title: const Text(
                    'S\'identifier',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: GlobalVariables.fourthColor),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signin)
                  Container(
                    decoration: BoxDecoration(
                      color: GlobalVariables.firstColor,
                      borderRadius: BorderRadius.only(
                          // topLeft: Radius.circular(10),
                          // topRight: Radius.circular(10),
                          ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          InputContainer(
                              inputController: _emailController,
                              hintText: 'Email'),
                          const SizedBox(height: 10),
                          CustomPasswordField(
                              controller: _passwordController,
                              hintText: 'mot de passe'),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: 'S\'identifier',
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInMedecin();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.only(
                      bottomStart:
                          _auth == Auth.signin ? Radius.circular(10) : Radius.circular(0),
                      bottomEnd:
                          _auth == Auth.signin ? Radius.circular(10) : Radius.circular(0),
                    ),
                  ),
                  tileColor: GlobalVariables.firstColor,
                  title: const Text(
                    'Créer un Compte Medecin',
                    style: TextStyle(
                      color: GlobalVariables.fourthColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signup)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    color: GlobalVariables.firstColor,
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          InputContainer(
                              inputController: _nameController,
                              hintText: 'nom et prenom'),
                          const SizedBox(height: 10),
                          InputContainer(
                              inputController:_idMatriculeController,
                              hintText:'idMatricule'),
                          InputContainer(
                              inputController: _emailController,
                              hintText: 'Email'),
                          const SizedBox(height: 10),
                          CustomPasswordField(
                              controller: _passwordController,
                              hintText: 'mot de passe'),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: getSpecialiteDropdown(),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "wilaya  ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: getWilayaDropdown(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "daira  ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: getDairaDropdown(),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomFormField(
                              inputController: _telephoneController,
                              hintText:'Telephone',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9]"),
                                )
                              ],
                            validator: (val) {
                              if (!val!.isValidPhone)
                              return 'Enter valid phone';
                              },
                          ),
                          const SizedBox(height: 10),
                          CustomDateField(
                              inputController: _ancienteController,
                              hintText: 'date debut'),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: 's\'inscrire',
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpMedecin();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
