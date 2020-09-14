import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/ColorsValues.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ColorsValues cv = ColorsValues();
  bool status = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Muzic',
          style: TextStyle(
            color: cv.white,
          ),
        ),
        backgroundColor: cv.darkRed,
      ),
      body: Container(
        child: GestureDetector(
          onTap: () {
            reqPermission();
          },
          child: Container(
              child: Center(
            child: Text('To enable notifications tap here..'),
          )),
        ),
      ),
    );
  }

  Future reqPermission() async {
    try {
      var res = await Permission.storage.status;
      if (!res.isUndetermined) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        print(permissionStatus.isGranted);
        print(res);
      }
    } catch (e) {
      print(e);
    }
  }
}
