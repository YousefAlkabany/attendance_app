import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/utils/attendance_icons.dart';
import 'package:cattendanceapp/widgets/custom_grid_button_container.dart';
import 'package:cattendanceapp/widgets/custom_pages_app_bar.dart';
import 'package:cattendanceapp/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ApplyApplicationPage extends StatefulWidget {
  const ApplyApplicationPage({super.key, this.userModel});
  final UserModel? userModel;

  static String id = 'applyapplication-page';

  @override
  State<ApplyApplicationPage> createState() => _ApplyApplicationPageState();
}

class _ApplyApplicationPageState extends State<ApplyApplicationPage> {
  @override
  Widget build(BuildContext context) {
    dynamic size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar:
          customPagesAppBar(widget.userModel!, context, 'Apply Application'),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width / 36, vertical: height / 36),
        child: Column(
          children: [
            CustomTextField(
              labelText: 'Title',
            ),
            SizedBox(
              height: height / 42,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 3,
              itemBuilder: (context, index) {
                return CustomGridButtonContainer(
                  image: AttendancePngimage.calendar,
                  title: 'Space Days',
                  time: '33',
                );
              },
            ),
            SizedBox(
              height: height / 42,
            ),
            CustomTextField(
              keyboardType: TextInputType.number,
              labelText: 'Contact Number',
            ),
            SizedBox(
              height: height / 42,
            ),
            CustomTextField(
              labelText: 'Start Date',
            ),
            SizedBox(
              height: height / 42,
            ),
            CustomTextField(
              labelText: 'End Date',
            ),
            SizedBox(
              height: height / 42,
            ),
            CustomTextField(
              labelText: 'Reason for Leave',
            ),
          ],
        ),
      ),
    );
  }
}
