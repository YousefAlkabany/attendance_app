import 'package:cattendanceapp/constants.dart';
import 'package:cattendanceapp/helpers/functions.dart';
import 'package:cattendanceapp/models/page_model.dart';
import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/services/page_services.dart';
import 'package:cattendanceapp/utils/attendance_color.dart';
import 'package:cattendanceapp/utils/attendance_fontstyle.dart';
import 'package:cattendanceapp/widgets/custom_pages_app_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  AboutUsPage({super.key, this.userModel});
  static String id = 'aboutus-page';
  UserModel? userModel;

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  PageModel? pageModel;

  Future<void> getPages(String token) async {
    try {
      pageModel = await PageServices(Dio()).getPages(token, 2);

      setState(() {});
    } catch (e) {
      showSnackBarMessage(context, e.toString());
    }
  }

  @override
  void initState() {
    getPages(widget.userModel!.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: customPagesAppBar(widget.userModel!, context, 'About Us'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 36, vertical: height / 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pageModel?.lastUpdatedAtStaticText ?? '',
                style: lmedium.copyWith(
                    fontSize: 13, color: AttendanceColor.textgray),
              ),
              SizedBox(
                height: height / 66,
              ),
              const Center(
                child: Image(
                  image: AssetImage(kLogo),
                  height: 150,
                ),
              ),
              SizedBox(
                height: height / 56,
              ),
              Text(
                pageModel?.headText ?? '',
                style: lregular.copyWith(
                    fontSize: 20, color: AttendanceColor.primary),
              ),
              SizedBox(
                height: height / 66,
              ),
              Text(
                pageModel?.bodyText ?? '',
                style: lregular.copyWith(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
