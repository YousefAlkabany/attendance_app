import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/utils/attendance_color.dart';

import 'package:flutter/material.dart';

AppBar customPagesAppBar(
    UserModel userModel, BuildContext context, String text) {
  dynamic size = MediaQuery.of(context).size;
  double height = size.height;

  return AppBar(
    flexibleSpace: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            AttendanceColor.teal,
            AttendanceColor.teal,
            Colors.yellow
          ])),
    ),
    surfaceTintColor: AttendanceColor.bgcolor,
    leading: InkWell(
        splashColor: AttendanceColor.transparent,
        highlightColor: AttendanceColor.transparent,
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: height / 36,
          color: Colors.yellow,
        )),
    title: Text(
      text,
      style: const TextStyle(
          fontSize: 20, fontFamily: 'LexendBold', color: Colors.white),
    ),
    centerTitle: true,
  );
}
