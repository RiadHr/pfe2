import 'package:flutter/material.dart';
import '../../constants/global_variables.dart';

class CustomDateField extends StatelessWidget {
  const CustomDateField({
    super.key,
    required TextEditingController inputController,
    required String this.hintText,
  }) : _inputController = inputController;

  final TextEditingController _inputController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlobalVariables.fourthColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        controller: _inputController,
        decoration: InputDecoration(
          hintText: hintText,
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
        ),

        onTap: () async {
          DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime(2100));
          if (selectedDate != null) {
            _inputController.text = selectedDate.toString();
          }
          print("test custom date field " + selectedDate.toString());
        },

        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Enter your $hintText';
          }
          return null;
        },
      ),
    );
  }
}