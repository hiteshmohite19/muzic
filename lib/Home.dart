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
  bool status = false;
  Widget homeWidget;

  @override
  void initState() {
    super.initState();
    handlePermission.permissionStatus().then((value) {
      if (value == false) {
        handlePermission.reqPermission().then((value) {
          setState(() {
            status = value;
          });
        });
      }
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    status = await handlePermission.permissionStatus();
    print('val $status');
    if (status == true) {
      listPage();
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
          child: homePage(),
        ));
  }

  Widget homePage() {
    var resp = getStatus();
    print('resp $resp');
    if (status == false) {
      print(status);
      setState(() {
        homeWidget = reqPermissionWidget();
      });
    }
    if (status) {
      setState(() {
        homeWidget = listPage();
      });
    }

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
        onTap: () async {
          status = await handlePermission.reqPermission();
        },
        child: Container(
            child: Center(
          child: Text('Click to allow storage access to load audio files'),
        )),
      ),
    );
  }

  getStatus() async {
    var resp = await handlePermission.permissionStatus();
    return resp;
  }
}
