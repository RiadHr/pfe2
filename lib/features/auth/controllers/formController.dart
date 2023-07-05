extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    print('email: ${emailRegExp.hasMatch(this)}');
    return emailRegExp.hasMatch(this);
  }

  bool get isNotNull{
    return this!=null;
  }

  bool get isValidPhone{
    final phoneRegExp = RegExp(r"^\+?0[0-9]{9}$");
    print('phone: ${phoneRegExp.hasMatch(this)}');
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidIdn{
    final idnRegExp = RegExp(r"^\+?[0-9]{12}$");
    print('idn: ${idnRegExp.hasMatch(this)}');
    return idnRegExp.hasMatch(this);
  }

}