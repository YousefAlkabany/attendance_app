import 'package:cattendanceapp/helpers/functions.dart';
import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/pages/home_page.dart';
import 'package:cattendanceapp/services/application_service.dart';
import 'package:cattendanceapp/services/date_and_time_picker_service.dart';
import 'package:cattendanceapp/utils/attendance_icons.dart';
import 'package:cattendanceapp/widgets/cards_select.dart';
import 'package:cattendanceapp/widgets/custom_grid_button_container.dart';
import 'package:cattendanceapp/widgets/custom_inkwell_button.dart';
import 'package:cattendanceapp/widgets/custom_pages_app_bar.dart';
import 'package:cattendanceapp/widgets/custom_text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyApplicationPage extends StatefulWidget {
  const ApplyApplicationPage({super.key, this.userModel});
  final UserModel? userModel;

  static String id = 'applyapplication-page';

  @override
  State<ApplyApplicationPage> createState() => _ApplyApplicationPageState();
}

class _ApplyApplicationPageState extends State<ApplyApplicationPage> {
  String? choosenLeaveType;
  List<String> leaveList = ['Medical', 'Emergency', 'Excuse', 'Casual'];
  List<String> leaveEmojiiList = ['💊', '🚨', '✋', '😎'];
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController choosenController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  Future<void> setDateAndTime(TextEditingController controller) async {
    controller.text =
        await DateAndTimePickerService().selectDateTime(context) ?? '';

    setState(() {});
  }

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
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Title',
                textController: titleController,
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return 'field is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                textAlign: TextAlign.center,
                enabled: false,
                controller: choosenController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                validator: (data) {
                  if (choosenLeaveType == null) {
                    showSnackBarMessage(context, 'please choose leave type');
                  }
                  return null;
                },
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  scrollDirection:
                      Axis.horizontal, // Make it scroll horizontally
                  itemCount: leaveList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: CardsSelect(
                        text: leaveList[index],
                        emojii: leaveEmojiiList[index],
                        onTap: () {
                          choosenLeaveType = leaveList[index];
                          choosenController.text = leaveList[index];
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: height / 42,
              ),
              CustomTextField(
                labelText: 'Contact Number',
                textController: numberController,
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return 'field is required';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: height / 42,
              ),
              CustomTextField(
                onTap: () {
                  setDateAndTime(startDateController);
                },
                readOnly: true,
                labelText: 'Start Date',
                textController: startDateController,
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.teal,
                  ),
                ),
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return 'field is required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: height / 42,
              ),
              CustomTextField(
                onTap: () {
                  setDateAndTime(endDateController);
                },
                readOnly: true,
                labelText: 'End Date',
                textController: endDateController,
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.teal,
                  ),
                ),
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return 'field is required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: height / 42,
              ),
              CustomTextField(
                labelText: 'Reason for Leave',
                textController: reasonController,
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return 'field is required';
                  }
                  return null;
                },
              ),
              const Spacer(),
              CustomInkwellButton(
                  text: 'Submit',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Map<String, dynamic> dataApplication = {
                        "title": titleController.text,
                        "leave_type": choosenLeaveType,
                        "contact_number": numberController.text,
                        "start_date": startDateController.text,
                        "end_date": endDateController.text,
                        "reason": reasonController.text
                      };
                      try {
                        ApplicationService(Dio()).sendApplication(
                            dataApplication, widget.userModel!.token);

                        showSnackBarMessage(
                            context, 'Application send successfully 📃');

                        Get.offAll(HomePage(
                          userModel: widget.userModel,
                        ));
                      } catch (e) {
                        showSnackBarMessage(context,
                            'something went wrong .. please try again later');
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
