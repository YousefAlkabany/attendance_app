import 'package:cattendanceapp/pages/profile/terms_and_conditions_page.dart';
import 'package:cattendanceapp/utils/attendance_color.dart';
import 'package:cattendanceapp/utils/attendance_fontstyle.dart';
import 'package:flutter/material.dart';

class InkwellRowItem extends StatelessWidget {
  const InkwellRowItem(
      {super.key,
      required this.text,
      required this.image,
      required this.onTap , 
      this.color =AttendanceColor.lightgrey});
  final String text;
  final String image;
  final VoidCallback onTap;
  final Color color; 

  @override
  Widget build(BuildContext context) {
    dynamic size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return InkWell(
      splashColor: AttendanceColor.transparent,
      highlightColor: AttendanceColor.transparent,
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color,
            child: Image.asset(
              image,
              height: height / 36,
              color: AttendanceColor.black,
            ),
          ),
          SizedBox(
            width: width / 26,
          ),
          Text(text,
              style: lmedium.copyWith(
                fontSize: 16,
              )),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: height / 46,
          )
        ],
      ),
    );
  }
}
