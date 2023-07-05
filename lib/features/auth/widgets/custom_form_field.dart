import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class CustomFormField extends StatelessWidget {

  CustomFormField({
    Key? key,
    required this.inputController,
    required this.hintText,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);

  final TextEditingController inputController;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        child: TextFormField(
          controller: inputController,
          inputFormatters: inputFormatters,
          validator: validator,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            hintText: hintText,
          ),
        ),
      ),
    );
  }

}