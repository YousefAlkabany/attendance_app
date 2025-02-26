import 'package:cattendanceapp/constants.dart';
import 'package:cattendanceapp/utils/attendance_color.dart';
import 'package:cattendanceapp/utils/attendance_fontstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBarMessage(BuildContext context, String message) {
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

// on back to see user sure or no

Future<bool> onbackpressed(BuildContext context, String text,
    Future<void> Function() onPressed) async {
  return await showDialog(
          builder: (context) => AlertDialog(
                title: Center(
                  child: Text("$kCompanyName Attendance".tr,
                      textAlign: TextAlign.center,
                      style: lsemiBold.copyWith(fontSize: 18)),
                ),
                content: Text(
                  
                  textAlign: TextAlign.center,
                  text,
                  style: lregular.copyWith(fontSize: 12),
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      await onPressed();
                      Get.back(result: true);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AttendanceColor.primary),
                    child: Text("Yes".tr,
                        style: lregular.copyWith(
                            color: AttendanceColor.white, fontSize: 13)),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AttendanceColor.primary),
                      onPressed: () {
                        Get.back(result: false);
                      },
                      child: Text(
                        "No".tr,
                        style: lregular.copyWith(
                            color: AttendanceColor.white, fontSize: 13),
                      )),
                ],
              ),
          context: context) ??
      false;
}
