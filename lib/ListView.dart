import 'dart:io';
import 'package:flutter/material.dart';

import 'ColorsValues.dart';

class ListView extends StatefulWidget {
  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<ListView> {
  ColorsValues cv = ColorsValues();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Muzic'),
        backgroundColor: cv.darkRed,
      ),
      body: Container(
        child: listViewWidget(context),
      ),
    );
  }

  // Widget listViewWidget(context) {
  //   return ListView(itemBuilder: (context, index) {
  //     return Card(
  //       child: ListTile(
  //         onTap: () {},
  //         title: Text(''),
  //       ),
  //     );
  //   });
  // }

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
