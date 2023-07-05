import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:dzair_data_usage/daira.dart';
import 'package:dzair_data_usage/dzair.dart';
import 'package:dzair_data_usage/langs.dart';
import 'package:dzair_data_usage/wilaya.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe2/features/auth/controllers/formController.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_passwordfield.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../../common/widgets/input_container.dart';
import '../../../constants/global_variables.dart';
import '../services/auth_service.dart';
import '../widgets/custom_form_field.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreenPatient extends StatefulWidget {
  static const String routeName = 'auth-screen-patient';
  const AuthScreenPatient({super.key});

  @override
  State<AuthScreenPatient> createState() => _AuthScreenPatientState();
}

class _AuthScreenPatientState extends State<AuthScreenPatient> {
  Auth _auth = Auth.signin;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idnController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  String dateNaisance='';
  String? selectedWilaya =
      Dzair().getWilayat()?.first?.getWilayaName(Language.FR);
  String? selectedDaira = Dzair().getDairat()?.first?.getDairaName(Language.FR);

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _idnController.dispose();
    _telephoneController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        idn: _idnController.text,
        telephone: _telephoneController.text,
        wilaya: selectedWilaya ?? '',
        daira: selectedDaira ?? '');
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    color: GlobalVariables.firstColor,
                    padding: const EdgeInsets.all(8),
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          InputContainer(
                              inputController: _emailController,
                              hintText: 'email'
                          ),
                          const SizedBox(height: 10),
                          CustomPasswordField(
                              controller: _passwordController,
                              hintText: 'mot de passe'),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 'S\'identifier',
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.only(
                      bottomStart: _auth == Auth.signin
                          ? Radius.circular(10)
                          : Radius.circular(0),
                      bottomEnd: _auth == Auth.signin
                          ? Radius.circular(10)
                          : Radius.circular(0),
                    ),
                  ),
                  tileColor: GlobalVariables.firstColor,
                  title: const Text(
                    'Créer un compte patient',
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
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: GlobalVariables.firstColor,
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          InputContainer(
                              inputController: _nameController,
                              hintText: 'nom et prenom'),
                          InputContainer(
                              inputController:_emailController, hintText: 'email'),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),
                            child: DropdownDatePicker(
                              inputDecoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ), // optional
                              isDropdownHideUnderline: true, // optional
                              isFormValidator: true, // optional
                              startYear: 1900, // optional
                              endYear: 2020, // optional
                              selectedMonth: 10, // optional
                              selectedYear: 1993, // optional
                              onChangedYear: (value) {
                                dateNaisance = value!.substring(2);
                                print('datenaissance = $dateNaisance');
                                print('onChangedYear: ${value}');
                              },
                              boxDecoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1.0)), // optional
                              showDay: false,// optional
                              showMonth: false, // optional
                              hintYear: 'Year', // optional
                              hintTextStyle: TextStyle(color: Colors.grey), // optional
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomFormField(
                              hintText: 'id carte chiffa',
                              inputController: _idnController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9]"),
                                )
                              ],
                              validator: (val) {
                                  print(dateNaisance);
                                  print('validator : ${!val!.isValidIdn || (val!.substring(0,1)!=dateNaisance)}');
                                if (!val!.isValidIdn || (val!.substring(0,2)!=dateNaisance)) {
                                  print('validation idn ${val.substring(0,2) == dateNaisance} and ${val.isValidIdn}');
                                  print(dateNaisance);
                                  print(val.substring(0,2));
                                  return 'Enter valid idn';
                                }
                              }),
                          SizedBox(height: 10),
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
                          CustomPasswordField(
                              controller: _passwordController,
                              hintText: "mot de passe"),
                          const SizedBox(height: 10),
                          CustomFormField(
                              hintText: 'Telephone',
                              inputController: _telephoneController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9]"),
                                )
                              ],
                              validator: (val) {
                                if (!val!.isValidPhone)
                                  return 'Enter valid phone';
                              }),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 's\'inscrire',
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                          ),
                          const SizedBox(height: 20),
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
