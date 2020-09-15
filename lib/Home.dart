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
    return ListView.builder(itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          onTap: () {},
          title: Text(''),
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

  Future reqPermission() async {
    var resp;

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
  }
}
