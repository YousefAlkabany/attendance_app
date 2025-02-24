import 'dart:io';

import 'package:cattendanceapp/constants.dart';
import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/utils/attendance_color.dart';
import 'package:flutter/material.dart';

class CustomAvatarWithStackedButton extends StatelessWidget {
  const CustomAvatarWithStackedButton(
      {super.key,
      required this.userModel,
      required this.onTap,
      this.selectedImage});
  final UserModel userModel;
  final VoidCallback onTap;
  final File? selectedImage;
  @override
  Widget build(BuildContext context) {
    dynamic size = MediaQuery.of(context).size;
    double height = size.height;

    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: selectedImage == null
              ? NetworkImage('$kImageNetworkUrl${userModel.image}')
              : FileImage(selectedImage!),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: height / 24,
              height: height / 24,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AttendanceColor.primary,
                  border: Border.all(color: AttendanceColor.white, width: 1)),
              child: Icon(Icons.camera_alt_outlined,
                  color: AttendanceColor.white, size: height / 40),
            ),
          ),
        )
      ],
    );
  }
}
