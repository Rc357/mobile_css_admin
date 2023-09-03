// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InputTextFieldNumberWidget extends StatelessWidget {
  final bool obscureText;
  final String label;
  final String? initialValue;
  final void Function(String?) onChanged;
  final String? Function(String?) validator;

  const InputTextFieldNumberWidget({
    Key? key,
    this.obscureText = false,
    required this.label,
    this.initialValue,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label.capitalizeFirst,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: Colors.blue), //<-- SEE HERE
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.blue), //<-- SEE HERE
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: Colors.red), //<-- SEE HERE
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red), //<-- SEE HERE
        ),
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      validator: validator,
    );
  }
}
