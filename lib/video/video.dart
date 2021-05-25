import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoListView extends StatefulWidget {
  @override
  _VideoListViewState createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {

  @override
    void initState() {
      super.initState();
      print(" ----  initState");
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Video"),
        ),
        body: Center(
          child: Text("Hellow world"),
        ),
    );
  }
}