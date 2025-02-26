import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.onChanged,
      this.labelText,
      this.validator,
      this.textController,
      this.isObsecured = false,
      this.keyboardType = TextInputType.text});

  final String? labelText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? textController;
  final bool isObsecured;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: isObsecured,
      controller: textController,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey[800]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.teal)),
      ),
    );
  }
}
