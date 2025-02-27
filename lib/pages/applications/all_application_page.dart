import 'package:cattendanceapp/helpers/functions.dart';
import 'package:cattendanceapp/models/application_model.dart';
import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/pages/applications/apply_application_page.dart';
import 'package:cattendanceapp/services/application_service.dart';
import 'package:cattendanceapp/utils/attendance_color.dart';
import 'package:cattendanceapp/utils/attendance_fontstyle.dart';
import 'package:cattendanceapp/widgets/custom_alert_container.dart';
import 'package:cattendanceapp/widgets/custom_pages_app_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllApplicationPage extends StatefulWidget {
  const AllApplicationPage({super.key, this.userModel});
  static String id = 'allapplication-page';
  final UserModel? userModel;

  @override
  State<AllApplicationPage> createState() => _AllApplicationPageState();
}

class _AllApplicationPageState extends State<AllApplicationPage> {
  List<ApplicationModel> applicationsList = [];
  // get pagges
  Future<void> getApplications() async {
    try {
      applicationsList = await ApplicationService(Dio())
              .getApplications(widget.userModel!.token) ??
          [];
      setState(() {});
    } catch (e) {
      showSnackBarMessage(context, e.toString());
    }
  }

  @override
  void initState() {
    getApplications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Stack(children: [
      Scaffold(
        appBar: customPagesAppBar(widget.userModel!, context, 'Applications'),
        body: applicationsList.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            width: width / 1,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: AttendanceColor.white),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 36,
                                  vertical: height / 56),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomAlertContainer(
                                          text: applicationsList[index].status),
                                      CustomAlertContainer(
                                          text: applicationsList[index]
                                              .leaveType),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${applicationsList[index].startDate.split(' ')[1]} ${applicationsList[index].startDate.split(' ')[2]}   ',
                                        style: lmedium.copyWith(fontSize: 14),
                                      ),
                                      const Text(
                                        'to',
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                          '   ${applicationsList[index].endDate.split(' ')[1]} ${applicationsList[index].endDate.split(' ')[2]}',
                                          style:
                                              lmedium.copyWith(fontSize: 14)),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Divider(
                                      indent: 16,
                                      endIndent: 16,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_month),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Start Day',
                                              style: lsemiBold.copyWith(
                                                  fontSize: 8),
                                            ),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            Text(
                                              applicationsList[index]
                                                  .startDate
                                                  .split(' ')[0],
                                              style: lregular.copyWith(
                                                  fontSize: 8),
                                            ),
                                          ]),
                                      const Spacer(),
                                      const Icon(Icons.calendar_month),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'End Day',
                                              style: lsemiBold.copyWith(
                                                  fontSize: 8),
                                            ),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            Text(
                                              applicationsList[index]
                                                  .endDate
                                                  .split(' ')[0],
                                              style: lregular.copyWith(
                                                  fontSize: 8),
                                            ),
                                          ])
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: height / 56,
                        );
                      },
                      itemCount: applicationsList.length,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              )
            : const Center(
                child: Text(
                  'No applications',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
      ),
      Positioned(
        bottom: 30,
        right: 20,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ApplyApplicationPage(userModel: widget.userModel);
                },
              ),
            );
          },
          backgroundColor: Colors.yellow, // Yellow background
          child: const Icon(
            Icons.add,
            color: Colors.black, // Black + icon
          ),
        ),
      ),
    ]);
  }
}
