import 'package:flutter/material.dart';

class PersonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Me"),
        ),
        body: Center(
          child: Text("Hellow world"),
        ),
    );
  }
}