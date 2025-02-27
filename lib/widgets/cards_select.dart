import 'package:flutter/material.dart';

class CardsSelect extends StatelessWidget {
  const CardsSelect(
      {super.key,
      required this.text,
      required this.emojii,
      required this.onTap});
  final String text;
  final String emojii;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      splashColor: Colors.yellow,
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(fontFamily: 'LexendBold', fontSize: 18),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              emojii,
              style: const TextStyle(fontFamily: 'LexendBold', fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
