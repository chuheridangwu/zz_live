import 'package:flutter/material.dart';
import 'package:zz_live/serve/app_data_model.dart';

class HomeItem extends StatelessWidget {
  final Anchor anchor;
HomeItem(this.anchor);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(anchor.headerIcon),fit: BoxFit.fill),
        ),
        child: bottomWidget(),
      ),
    );
  }

  // 底部昵称和观看人数
  Widget bottomWidget(){
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(5),
      child:  Row(
            children: [
              Expanded(child: Text(anchor.userName,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)),
              Text("${anchor.watchNum}",style: TextStyle(color: Colors.white,fontSize: 13),textAlign: TextAlign.right,),
          ],),
    );
  }

}