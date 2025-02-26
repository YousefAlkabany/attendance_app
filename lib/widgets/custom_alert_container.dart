import 'package:cattendanceapp/utils/attendance_color.dart';
import 'package:cattendanceapp/utils/attendance_fontstyle.dart';
import 'package:flutter/material.dart';

class CustomAlertContainer extends StatelessWidget {
  const CustomAlertContainer(
      {super.key, required this.text, this.color = AttendanceColor.teal});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    dynamic size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AttendanceColor.lightteal),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width / 36, vertical: height / 96),
        child: Text(
          text,
          style: lregular.copyWith(
            fontSize: 12,
            color: color,
          ),
        ),
      ),
    );
  }
}
