import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/ColorsValues.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';

import 'HandlePermission.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ColorsValues cv = ColorsValues();
  HandlePermission handlePermission = HandlePermission();
  bool status;
  Widget homeWidget;

  @override
  void initState() {
    super.initState();
    homePage();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    setState(() async {
      status = await handlePermission.permissionStatus();
    });
    if (status) {
      setState(() {
        homeWidget = listPage();
      });
    }
    if (!status) {
      setState(() {
        homeWidget = reqPermissionWidget();
      });
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
          child: SpinKitFadingCircle(
            color: cv.darkRed,
            size: 30,
          ),
        ));
  }

  Widget homePage() {
    return homeWidget;
  }

  Widget listPage() {
    return Center(
      child: Text('True'),
    );
  }

  Widget reqPermissionWidget() {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() async {
            status = await handlePermission.reqPermission();
          });
        },
        child: Container(
            child: Center(
          child: Text('Click to allow storage access to load audio files'),
        )),
      ),
    );
  }
}
