import 'dart:convert';
import 'package:flutter/services.dart';

class GiftManager {
  // 当前选择的礼物
  Gift currentGift;
  List<GiftGroup> giftGroups = [];

  // 单例公开访问点
  factory GiftManager() => _shareInstance();

  // 静态私有成员，没有初始化
  static GiftManager _giftManager = GiftManager._();

  // 私有构造函数
  GiftManager._() {}

  static Future<List<GiftGroup>> getGiftData() async {
    String jsonString = await rootBundle.loadString("assets/gift.json");
    Map<String, dynamic> jsonData = json.decode(jsonString);
    List<dynamic> giftDatas = jsonData["gift_data"];
    List<dynamic> giftTypes = jsonData["gift_type"];

    List<GiftGroup> giftGroups = [];
    for (var item in giftTypes) {
      GiftGroup group = GiftGroup();
      group.type = int.parse(item["type_id"]);
      group.name = item["name"];
      group.gifts = [];

      for (var item in giftDatas) {
        Gift gift = Gift.from(
            int.parse(item["gift_id"]),
            item["gift_name"],
            item["gift_image"],
            false,
            int.parse(item["gift_type"]),
            item["price"]);
        if (gift.giftType == group.type) {
          group.gifts.add(gift);
        }
      }
      if (group.gifts.length != 0) {
        giftGroups.add(group);
      }

      _giftManager.giftGroups = giftGroups;

      // 默认选中第一个
      if (_giftManager.giftGroups.length != 0 && _giftManager.giftGroups[0].gifts.length != 0) {
        _giftManager.currentGift = _giftManager.giftGroups[0].gifts[0];
      }
    }
    return giftGroups;
  }

  // 静态、同步、私有访问点
  static GiftManager _shareInstance() {
    if (_giftManager == null) {
      _giftManager = GiftManager();
    }
    return _giftManager;
  }
}

class GiftGroup {
  int type;
  String name;
  List<Gift> gifts;
}

class Gift {
  int giftId; // 礼物
  String giftName; // 礼物名称
  String giftIcon; // 礼物图标
  bool isSelected; // 选中状态
  int giftType; // 礼物分类
  String price; //礼物价格
  int number; // 选择数量

  List<int> numbers = [1,9,99,199,520];

  Gift.from(this.giftId, this.giftName, this.giftIcon, this.isSelected,
      this.giftType, this.price,{this.number = 1});
}
