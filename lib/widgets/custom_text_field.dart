import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.onChanged,
      this.labelText,
      this.validator,
      this.textController,
      this.isObsecured = false,
      this.keyboardType = TextInputType.text,
      this.suffixIcon,
      this.readOnly = false , this.onTap});

  final String? labelText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? textController;
  final bool isObsecured;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback ? onTap; 
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      keyboardType: keyboardType,
      obscureText: isObsecured,
      controller: textController,
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
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
