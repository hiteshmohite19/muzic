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
  bool storage_access_status = false;
  var file_name = [];

  @override
  void initState() {
    super.initState();
    print(reqPermission());
    if (reqPermission() == 'true') {
      listViewWidget(context);
    } else {
      reqPermission();
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
          child: homeWidget(context),
        ));
  }

  Widget listViewWidget(context) {
    return ListView.builder(
        itemCount: file_name.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {},
              title: Text(file_name[index].File),
            ),
          );
        });
  }

  Widget reqPermissionWidget() {
    return Container(
      child: GestureDetector(
        onTap: () {
          reqPermission();
        },
        child: Container(
            child: Center(
          child: Text('To enable notifications tap here..'),
        )),
      ),
    );
  }

  Widget homeWidget(context) {
    if (storage_access_status == true) {
      return listViewWidget(context);
    } else {
      return reqPermissionWidget();
    }
  }

  Future reqPermission() async {
    var resp;
    try {
      var res = await Permission.storage.status;
      PermissionStatus permissionStatus = await Permission.storage.request();
      if (!res.isGranted) {
        // PermissionStatus permissionStatus = await Permission.storage.request();
        print('permission ${permissionStatus.isGranted}');
        // print('res ${res}');
        setState(() {
          storage_access_status = true;
          listViewWidget(context);
        });
        resp = 'true';
      }
      // return permissionStatus.isGranted;
    } catch (e) {
      print(e);
      resp = 'false';
    }

    return resp;
  }

  loadFiles() {
    Directory dir = Directory('/storage/emulated/0/');
    String mp3Path = dir.toString();
    print(mp3Path);
    List<FileSystemEntity> _files;
    List<FileSystemEntity> _songs = [];
    _files = dir.listSync(recursive: true, followLinks: false);
    for (FileSystemEntity entity in _files) {
      String path = entity.path;
      if (path.endsWith('.mp3')) _songs.add(entity);
    }
    print(_songs);
    print(_songs.length);
    file_name = _songs;
    print(file_name.length);
  }
}
