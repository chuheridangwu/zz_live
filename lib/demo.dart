import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DemoTest extends StatefulWidget {
  @override
  _DemoTestState createState() => _DemoTestState();
}

class _DemoTestState extends State<DemoTest> {

  ScrollController _controller = ScrollController();

  @override
    void initState() {
      super.initState();
      _controller.addListener(() {
        print("当前滚动的距离: ${_controller.offset}");
      });
    }

  @override
  Widget build(BuildContext context) {
    return  Material(
      child: NotificationListener(
        onNotification: (ScrollNotification notification){
          if (notification is ScrollStartNotification) { //开始滚动
            
          } else if (notification is ScrollUpdateNotification) { //正在滚动
            
          } else if(notification is ScrollEndNotification){ //结束滚动
          
          }
          return true;
        },
        child: ListView(
          controller: _controller,
          children: List.generate(100, (index){
            return Text("index --- $index");
          }),
        ),
      )
    );
  }
}