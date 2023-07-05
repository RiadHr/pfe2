import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';
import 'custom_textfield.dart';


class InputContainer extends StatelessWidget {
  const InputContainer({
    super.key,
    required TextEditingController inputController,
    required String this.hintText
  }) : _inputController = inputController;

  final TextEditingController _inputController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: GlobalVariables.fourthColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: CustomTextField(
        controller: _inputController,
        hintText: hintText,

      ),
    );
  }
}