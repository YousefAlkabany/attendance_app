import 'package:cattendanceapp/utils/attendance_color.dart';
import 'package:cattendanceapp/utils/attendance_fontstyle.dart';
import 'package:flutter/material.dart';

class CustomInkwellButton extends StatefulWidget {
  const CustomInkwellButton({super.key, required this.text, this.onTap});
  final VoidCallback? onTap;
  final String text;
  @override
  State<CustomInkwellButton> createState() => _CustomInkwellButtonState();
}

class _CustomInkwellButtonState extends State<CustomInkwellButton> {
  @override
  Widget build(BuildContext context) {
    dynamic size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return InkWell(
      splashColor: AttendanceColor.transparent,
      highlightColor: AttendanceColor.transparent,
      onTap: widget.onTap,
      child: Container(
        height: height / 15,
        width: width / 1,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: AttendanceColor.primary,
        ),
        child: Center(
          child: Text(
            widget.text,
            style: lmedium.copyWith(
              fontSize: 16,
              color: AttendanceColor.white,
            ),
          ),
        ),
      ),
    );
  }
}
