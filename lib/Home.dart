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
    homePage();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var resp = await handlePermission.permissionStatus();
    setState(() {
      status = resp;
      if (status == false) {
        reqPermissionWidget();
      }
      print(status);
    });
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
            size: 40,
          ),
        ));
  }

  Widget homePage() {
    print(status);
    // while(status == null) {
    //   return SpinKitFadingCircle(
    //     color: cv.darkRed,
    //     size: 30,
    //   );
    // }

    if (status) {
      print(status);
      setState(() {
        homeWidget = listPage();
      });
    }
    if (!status) {
      print(status);
      setState(() {
        homeWidget = reqPermissionWidget();
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
}
