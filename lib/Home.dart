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
    if (status == false) {
      permissionStatus();
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    bool res1 = await reqPermission();
    print('values $res1');
    bool res = await permissionStatus();
    print('vales $res');
    setState(() {
      status = res;
    });
    print('$res $res1');
    if (res == true || res1 == true) {
      
      listPage();
      print('true');
    } else {
      reqPermissionWidget();
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
    var widget;
    if (status == true) {
      widget = listPage();
    }
    if (status == false) {
      widget = reqPermissionWidget();
    }

    return widget;
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
          reqPermission();
        },
        child: Container(
            child: Center(
          child: Text('Click to allow storage access to load audio files'),
        )),
      ),
    );
  }

  Future<bool> reqPermission() async {
    var status = await Permission.storage.isGranted;
    if (!status) {
      PermissionStatus permissionStatus = await Permission.storage.request();
      if (permissionStatus.isGranted) {
        print('values ${permissionStatus.isGranted}');
        setState(() {
          status = true;
        });
        return true;
      }
    }
  }

  Future<bool> permissionStatus() async {
    if (await Permission.storage.status.isGranted) {
      return true;
    } else {
      reqPermissionWidget();
      return false;
    }
  }
}
