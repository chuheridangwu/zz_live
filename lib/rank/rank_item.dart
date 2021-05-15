import 'package:flutter/material.dart';
import 'package:zz_live/serve/app_data_model.dart';

class RankItem extends StatelessWidget {
  final UserInfo user;
  final int index;
  RankItem(this.user,this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          Text("$index",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,)),
          ClipOval(child: Image.network(user.headerIcon,width: 60,height: 60,fit: BoxFit.cover,)),
          Column(
            children: [
              Text(user.userName),
              Text("${user.level}")
            ],
          ),
          Text("${user.coins}",textAlign: TextAlign.right,)
        ],
      ),
    );
  }
}