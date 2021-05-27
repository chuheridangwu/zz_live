import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zz_live/serve/app_data_model.dart';

class LiveEndView extends StatefulWidget {
  final Anchor anchor;
  LiveEndView(this.anchor);
  @override
  _LiveEndViewState createState() => _LiveEndViewState();
}

class _LiveEndViewState extends State<LiveEndView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.anchor.headerIcon),
              fit: BoxFit.cover)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
                child: Image.network(widget.anchor.headerIcon,
                    width: 110, height: 110, fit: BoxFit.cover)),
            SizedBox(
              height: 10,
            ),
            Text(
              "${widget.anchor.userName}",
              style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            liveEndTipWidget(),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                
              },
              child: Text("关注主播"),
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("退出房间")),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  // 中间的提示
  Widget liveEndTipWidget(){
    return Container(
      child: Column(
        children: [
              Divider(height: 1.0,indent: 20.0,endIndent: 20,color: Colors.white,),
              SizedBox(height: 8,),
              Text("直播已结束"),
              SizedBox(height: 3,),
              Text("关注主播不迷路，主播带你上高速"),
              SizedBox(height: 8,),
              Divider(height: 1.0,indent: 20.0,endIndent: 20,color: Colors.white,),
        ],
      ),
    );
  }

}
