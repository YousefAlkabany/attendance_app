import 'dart:developer';

import 'package:cattendanceapp/constants.dart';
import 'package:cattendanceapp/helpers/functions.dart';
import 'package:cattendanceapp/models/attendance_model.dart';
import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/services/area_service.dart';
import 'package:cattendanceapp/services/attendance_save_service.dart';
import 'package:cattendanceapp/utils/attendance_color.dart';
import 'package:cattendanceapp/utils/attendance_fontstyle.dart';
import 'package:cattendanceapp/utils/attendance_icons.dart';
import 'package:cattendanceapp/utils/utils.dart';
import 'package:cattendanceapp/widgets/custom_app_bar.dart';
import 'package:cattendanceapp/widgets/custom_grid_button_container.dart';
import 'package:cattendanceapp/widgets/custom_title.dart';
import 'package:cattendanceapp/widgets/drop_box_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.userModel});

  static String id = 'home-page';

  UserModel? userModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List? areas = [];
  List<AttendanceModel> attendanceList = [];
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  dynamic _value;
  AttendanceModel? attendanceModel;
  String timeIn = '';
  String timeOut = '';
  bool checkInOnTap = false;
  bool checkOutOnTap = false;
  int totalDaysCounter = 0;
  int totalSpaceCounter = 0;
  bool isExpandedView = false;
  CollectionReference activities =
      FirebaseFirestore.instance.collection('activities');
  CollectionReference counters =
      FirebaseFirestore.instance.collection('counters');
  Map<String, dynamic> counterData = {};
  bool isLoading = true;
  late ProgressDialog pr;

  late Position _currentPosition;
  final Geolocator geoLocator = Geolocator();
  late dynamic subscription;

  //Utils
  Utils utils = Utils();

  // Get latitude longitude
  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBarMessage(context, 'You Should open the location service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    subscription = Geolocator.getPositionStream().listen((position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
          print('yousef $_currentPosition');
        });
      }
    });
  }

  // function to return area list
  Future<void> getAreaList(String token) async {
    var fetchedData = await AreaService(Dio()).getAreaList(token);

    setState(() {
      areas = fetchedData;
    });
  }

  // function to return counter data for user
  Future<void> fetchData() async {
    DocumentSnapshot snapshot =
        await counters.doc(widget.userModel!.id.toString()).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    setState(() {
      counterData = data;
      isLoading = false;
    });

    totalDaysCounter = counterData['totalCounter'] as int;
    totalSpaceCounter = counterData['spaceCounter'] as int;
  }

  @override
  void initState() {
    getAreaList(widget.userModel!.token);
    _getCurrentLocation();

    fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show progress
    pr = ProgressDialog(
      context,
      isDismissible: false,
      type: ProgressDialogType.normal,
    );
    // Style progress
    pr.style(
      message: 'Wait a moment...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: const CircularProgressIndicator(),
      elevation: 10.0,
      padding: const EdgeInsets.all(10.0),
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
      ),
      messageTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 19.0,
        fontWeight: FontWeight.w600,
      ),
    );
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    int viewAllCounter = isExpandedView
        ? attendanceList.length
        : attendanceList.length >= 4
            ? 4
            : attendanceList.length;

    return Scaffold(
      key: _scaffoldKey,
      appBar: customAppBar(widget.userModel!, context),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropBoxContainer(
                onChanged: (newValue) {
                  setState(() {
                    _value = newValue;
                  });
                },
                areas: areas!,
                value: _value,
              ),
              const CustomTitle(title: 'Today Attendance :'),
              const SizedBox(
                height: 12,
              ),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: (height / 3.99) / (width / 2.2)),
                children: [
                  CustomGridButtonContainer(
                    activeColor: Colors.teal,
                    isActive: checkInOnTap,
                    image: kCheckInImage,
                    title: 'Check IN',
                    onTap: () async {
                      checkInOnTap = true;
                      checkOutOnTap = false;
                      setState(() {});
                      await saveAttendance(context, 'in', widget.userModel!);
                    },
                    time: timeIn,
                  ),
                  CustomGridButtonContainer(
                    activeColor: const Color.fromARGB(255, 252, 116, 104),
                    isActive: checkOutOnTap,
                    image: kCheckOutImage,
                    title: 'Check Out',
                    onTap: () async {
                      checkOutOnTap = true;
                      checkInOnTap = false;
                      setState(() {});
                      await saveAttendance(context, 'out', widget.userModel!);
                    },
                    time: timeOut,
                  ),
                  CustomGridButtonContainer(
                    image: AttendancePngimage.calendar,
                    title: 'Total Days',
                    time: '${counterData['totalCounter']}',
                  ),
                  CustomGridButtonContainer(
                    image: AttendancePngimage.calendar,
                    title: 'Space Days',
                    time: '${counterData['spaceCounter']}',
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTitle(title: 'Days Activity :'),
                  if (attendanceList.isNotEmpty)
                    attendanceList.length > 5
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpandedView = !isExpandedView;
                              });
                            },
                            child: Text(
                              isExpandedView ? "View Less" : "View All",
                              style: lsemiBold.copyWith(
                                  fontSize: 14, color: Colors.teal),
                            ),
                          )
                        : Text(
                            "View All",
                            style: lsemiBold.copyWith(
                                fontSize: 14, color: Colors.grey),
                          ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: activities.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && attendanceList.isEmpty) {
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      if (snapshot.data!.docs[i]["id"] ==
                          widget.userModel!.id) {
                        attendanceList.add(
                          AttendanceModel.fromJson(snapshot.data!.docs[i],
                              image: snapshot.data!.docs[i]['image']),
                        );
                      }
                    }
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
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
                              horizontal: width / 36, vertical: height / 56),
                          child: Row(
                            children: [
                              Container(
                                height: height / 20,
                                width: height / 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AttendanceColor.lightprimary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(
                                    '${attendanceList[index].image}',
                                    height: height / 36,
                                    color: AttendanceColor.primary,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width / 36,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${attendanceList[index].query}',
                                    style: lsemiBold.copyWith(fontSize: 14),
                                  ),
                                  Text(
                                    '${attendanceList[index].date}',
                                    style: lregular.copyWith(
                                        fontSize: 12,
                                        color: AttendanceColor.textgray),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${attendanceList[index].time}',
                                    style: lsemiBold.copyWith(fontSize: 14),
                                  ),
                                  Text(
                                    '${attendanceList[index].location}',
                                    style: lregular.copyWith(
                                        fontSize: 12,
                                        color: AttendanceColor.textgray),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: height / 56,
                      );
                    },
                    itemCount: viewAllCounter,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // function to save attendance and handle each message ;

  Future<void> saveAttendance(
      BuildContext context, String q, UserModel userModel) async {
    //take a firebase inistance

    try {
      Response response = await AttendanceSaveService(Dio()).saveAttendance(
          widget.userModel!.token,
          q,
          widget.userModel!.id.toString(),
          _value,
          _currentPosition.latitude.toString(),
          _currentPosition.longitude.toString());

      final data = response.data;

      if (data['message'] == 'Success!') {
        attendanceModel = AttendanceModel.fromJson(data);

        // adding the data to fire cloud store

        activities.add({
          'id': userModel.id,
          'date': attendanceModel!.date,
          'time': attendanceModel!.time,
          'query': attendanceModel!.query,
          'location': attendanceModel!.location,
          'image': q == 'in' ? kCheckInImage : kCheckOutImage,
        });

        attendanceList.add(
          AttendanceModel(
            userId: userModel.id,
            date: attendanceModel!.date,
            time: attendanceModel!.time,
            query: attendanceModel!.query,
            location: attendanceModel!.location,
            image: q == 'in' ? kCheckInImage : kCheckOutImage,
          ),
        );

        Future.delayed(Duration.zero).then((value) async {
          if (mounted) {
            subscription.cancel();
            await pr.hide();
            Alert(
              context: _scaffoldKey.currentContext!,
              type: AlertType.success,
              title: "Success",
              desc: 'Yes, check-$q successfully!',
              style: const AlertStyle(
                descStyle: TextStyle(color: Colors.black, fontSize: 20),
                titleStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              buttons: [
                DialogButton(
                  color: kButtonSuccessColor,
                  onPressed: () {
                    setState(() {
                      _value;
                    });
                    Navigator.pop(
                      context,
                    );
                  },
                  width: 120,
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ).show();
          }
        });
        if (q == 'in') {
          setState(() {
            timeIn = attendanceModel!.time!;
            if (attendanceModel!.location == kAnotherSpace) {
              totalSpaceCounter++;

              counters
                  .doc(
                userModel.id.toString(),
              )
                  .update(
                {'spaceCounter': totalSpaceCounter},
              );
            }
            totalDaysCounter++;
            counters
                .doc(
              userModel.id.toString(),
            )
                .update(
              {'totalCounter': totalDaysCounter},
            );
          });
        } else {
          setState(() {
            timeOut = attendanceModel!.time!;
          });
        }
      } else if (data['message'] == 'location not found') {
        checkInOnTap = false;
        checkOutOnTap = false;
        setState(() {});
        Future.delayed(Duration.zero).then((value) async {
          await pr.hide();

          utils.showAlertDialog(
            'location not found',
            "warning",
            AlertType.warning,
            _scaffoldKey,
            isAnyButton: true,
          );
        });
      } else if (data['message'] == 'check-in first') {
        checkOutOnTap = false;
        Future.delayed(Duration.zero).then((value) async {
          await pr.hide();

          utils.showAlertDialog(
            "Please check-in first.",
            "warning",
            AlertType.warning,
            _scaffoldKey,
            isAnyButton: true,
          );
        });
      } else if (data['message'] == 'already check-in') {
        checkInOnTap = true;
        setState(() {});
        Future.delayed(Duration.zero).then((value) async {
          await pr.hide();

          utils.showAlertDialog(
            'You have checked-in.',
            "warning",
            AlertType.warning,
            _scaffoldKey,
            isAnyButton: true,
          );
        });
      } else if (data['message'] == 'cannot attend') {
        checkInOnTap = false;
        checkOutOnTap = false;
        setState(() {});
        Future.delayed(Duration.zero).then((value) async {
          await pr.hide();

          utils.showAlertDialog(
            'You cannot attend. Your current location is outside from area.',
            "warning",
            AlertType.warning,
            _scaffoldKey,
            isAnyButton: true,
          );
        });
      }
    } catch (e) {
      if (_value == null) {
        checkInOnTap = false;
        checkOutOnTap = false;
        setState(() {});
        Future.delayed(Duration.zero).then((value) async {
          await pr.hide();

          utils.showAlertDialog(
            'Please select the area first',
            "warning",
            AlertType.warning,
            _scaffoldKey,
            isAnyButton: true,
          );
        });
      } else {
        showSnackBarMessage(
            context, "something went wrong .. please try again later");
      }
    }
  }
}
