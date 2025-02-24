import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          textAlign: TextAlign.start,
          title,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'LexendSemiBold',
          ),
        ),
      ],
    );
  }
}
