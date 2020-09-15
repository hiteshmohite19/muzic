import 'dart:io';
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
  bool status;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    bool res = await permissionStatus();
    setState(() {
      status = res;
    });
    if (res == true) {
      print('true');
    } else {
      print('false');
    }
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
          child: homeWidget(),
        ));
  }

  Widget homeWidget() {
    print(status);
    return Center(
      child: Text(''),
    );
  }



  Widget reqPermissionWidget() {
    return Container(
      child: GestureDetector(
        onTap: () {},
        child: Container(
            child: Center(
          child: Text('To enable notifications tap here..'),
        )),
      ),
    );
  }



  Future<bool> permissionStatus() async {
    if (await Permission.storage.status.isGranted) {
      return true;
    } else {
      return false;
    }
  }


}
