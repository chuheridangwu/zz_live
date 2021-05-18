import 'package:flutter/material.dart';
import 'package:zz_live/serve/app_data_model.dart';

class HomeItem extends StatelessWidget {
  final Anchor anchor;
  VoidCallback onPress; // 回调函数
HomeItem(this.anchor,this.onPress);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(anchor.headerIcon),fit: BoxFit.fill),
          ),
          child: bottomWidget(),
        ),
      ),
      onTap: onPress,
    );
  }

  // 底部昵称和观看人数
  Widget bottomWidget(){
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(5),
        child:  Row(
              children: [
                Expanded(child: Text(anchor.userName,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)),
                Text("${anchor.watchNum}",style: TextStyle(color: Colors.white,fontSize: 13),textAlign: TextAlign.right,),
            ],),
      );
  }

}