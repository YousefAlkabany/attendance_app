import 'package:cattendanceapp/constants.dart';
import 'package:cattendanceapp/models/user_model.dart';
import 'package:cattendanceapp/pages/profile_page.dart';

import 'package:flutter/material.dart';

AppBar customAppBar(UserModel userModel, BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.teal,
    elevation: 12,
    shadowColor: Colors.black,
    centerTitle: true,
    title: const Text(
      'Attendance $kCompanyName',
      style: TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontFamily: 'LexendBold',
      ),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
    leading: InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProfilePage.id, arguments: userModel);
      },
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: const Icon(
        Icons.settings,
        color: Colors.white,
      ),
    ),
    actions: [
      Row(
        children: [
          InkWell(
            onTap: () {},
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: const Padding(
              padding: EdgeInsets.all(6.0),
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: const Padding(
              padding: EdgeInsets.all(6.0),
              child: Icon(
                Icons.check_box,
                color: Colors.white,
              ),
            ),
          ),
        ],
      )
    ],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(110),
      child: Container(
        padding: const EdgeInsets.only(left: 30, bottom: 20),
        child: Row(
          children: [
            CircleAvatar(
                backgroundColor: Colors.yellow,
                radius: 33,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage('$kImageNetworkUrl${userModel.image}'),
                )
                // Icon(Icons.person) ;  if null
                ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'LexendBold',
                    ),
                  ),
                  Text(
                    userModel.email,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'LexendRegular',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
