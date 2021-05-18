import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// class PersonView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Me"),
//         ),
//         body: Center(
//           child: Text("Hellow world"),
//         ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PersonView extends StatefulWidget {
  @override
  _PersonViewState createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(fit: StackFit.expand,
      children: [
        Text("data"),
        Positioned(
              left: 5,
              right: 5,
              top: 10,
              child: SafeArea(
                child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Image.asset("images/room/room_public.png",width: 30,height: 30,),
                     
                      IconButton(
                        iconSize: 30,
                          icon: Image.asset("images/room/room_gift.png", width: 35,height: 35,),
                          onPressed: () {}),
                      SizedBox(
                        width: 25,
                      ),
                      IconButton(
                        iconSize: 15,
                          icon: Image.asset("images/room/room_share.png",),
                          onPressed: () {}),
                      IconButton(
                          icon: Image.asset("images/room/room_close.png",),
                          onPressed: () {}),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ),
        Text("111")
      ],
      ),
    );
  }
}