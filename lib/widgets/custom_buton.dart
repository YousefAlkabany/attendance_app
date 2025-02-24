import 'package:cattendanceapp/constants.dart';
import 'package:flutter/material.dart';

class CustomButon extends StatelessWidget {
  const CustomButon({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: kAppButtonsColor, borderRadius: BorderRadius.circular(8)),
        height: 60,
        width: double.infinity,
        child: Center(
          child: Text(
            style: const TextStyle(color: Colors.white),
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
