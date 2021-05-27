import 'dart:math';

import 'package:flutter/material.dart';

import 'gift_item.dart';
import 'gift_manager.dart';

class GiftListView extends StatefulWidget {
  @override
  _GiftListViewState createState() => _GiftListViewState();
}

class _GiftListViewState extends State<GiftListView>
    with SingleTickerProviderStateMixin {
  // 礼物数据
  List<GiftGroup> _giftGroups = [];

  // TabController
  TabController _tabController;

  // 初始化
  @override
  void initState() {
    super.initState();
    // 获取礼物数据
    GiftManager.getGiftData().then((List<GiftGroup> value) {
      setState(() {
        _giftGroups = value;
        _tabController = TabController(length: _giftGroups.length, vsync: this);
      });
    });
  }

  // build UI
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black38,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            giftTypeWidget(),
            giftListWidget(),
            bottomViewWidget(),
          ],
        ),
      ),
    );
  }

  // 礼物分类列表
  Widget giftTypeWidget() {
    return Container(
      height: 40,
      child: DefaultTabController(
          length: _giftGroups.length,
          child: TabBar(
            indicator: const BoxDecoration(),
            automaticIndicatorColorAdjustment: false,
            controller: _tabController,
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
            onTap: (index) {},
            tabs: _giftGroups.map((value) {
              return Text(
                "${value.name}",
                maxLines: 1,
              );
            }).toList(),
          )),
    );
  }

  // 礼物列表
  Widget giftListWidget() {
    return SizedBox(
      height: 220,
      child: DefaultTabController(
        length: _giftGroups.length,
        child: TabBarView(
            controller: _tabController,
            children: _giftGroups.map((giftGroup) {
              return itemView(giftGroup.gifts);
            }).toList()),
      ),
    );
  }

  // 判断当前礼物是否属于选中状态
  void refreshSelectedGift() {
      setState(() {
        for (var giftGroup in GiftManager().giftGroups) {
          for (var item in giftGroup.gifts) {
            if (item.giftId == GiftManager().currentGift.giftId) {
              item.isSelected = true;
            } else {
              item.isSelected = false;
            }
          }
        }
      });
  }

  // 单个礼物Item
  Widget itemView(List<Gift> gifts) {
    return GridView.builder(
      primary: true,
      scrollDirection: Axis.horizontal,
      itemCount: gifts.length,
      itemBuilder: (ctx, index) {
        Gift gift = gifts[index];
        if (gift.giftId == GiftManager().currentGift.giftId) {
          gift.isSelected = true;
        }
        GiftItem giftItem = GiftItem(
          gift,
          callback: (item) {
            refreshSelectedGift();
          },
        );
        return giftItem;
      },
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }

  // 礼物面板底部Widget
  Widget bottomViewWidget() {
    return Row(
      children: [
        SizedBox(
          width: 5,
        ),
        Icon(Icons.code),
        Text(
          "100000",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              "Topup>>",
              style: TextStyle(color: Colors.yellow, fontSize: 16),
            )),
        Expanded(
          child: Text(
            "to",
            style: TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.right,
          ),
        ),
        SingleChildScrollView(
          child: Text(
            "主播的昵称",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        TextButton(
            onPressed: () {},
            child: Text("送礼物",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    backgroundColor: Colors.red))),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }
}
