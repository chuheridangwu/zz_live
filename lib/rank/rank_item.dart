import 'package:flutter/material.dart';
import 'package:zz_live/serve/app_data_model.dart';

class RankItem extends StatelessWidget {
  final UserInfo user;
  final int index;
  RankItem(this.user, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            indexWidget(),
            SizedBox(
              width: 8,
            ),
            headImgWidget(),
            SizedBox(
              width: 8,
            ),
            nameAndLevelWidget(),
            SizedBox(
              width: 5,
            ),
            Text(
              "${user.coins} 钻石",
              textAlign: TextAlign.right,
            )
          ],
        ),
      ),
    );
  }

  // 榜单索引
  Widget indexWidget() {
    return index <= 3
        ? Image.asset("images/rank/rank_num$index.png", width: 30)
        : Container(
            width: 30,
            child: Center(
              child: Text("$index",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  )),
            ),
          );
  }

  // 头像
  Widget headImgWidget() {
    return ClipOval(
        child: Image.network(
      user.headerIcon,
      width: 60,
      height: 60,
      fit: BoxFit.cover,
    ));
  }

  // 用户昵称和图标
  Widget nameAndLevelWidget() {
    int level = user.level % 10;
    if (level > 15) {
      level = 15;
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.userName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          SizedBox(height: 5,),
          Image.asset("images/level/vip_$level.png"),
        ],
      ),
    );
  }
}
