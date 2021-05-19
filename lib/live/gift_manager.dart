class GiftManager {

  // 当前选择的礼物
  Gift currentGift;
  GiftGroup giftGroup;

  // 单例公开访问点
  factory GiftManager() => _shareInstance();

  // 静态私有成员，没有初始化
  static GiftManager _giftManager = GiftManager._();

  // 私有构造函数
  GiftManager._() {}

  // 静态、同步、私有访问点
  static GiftManager _shareInstance() {
    if (_giftManager == null) {
      _giftManager = GiftManager();
    }
    return _giftManager;
  }

}

class GiftGroup{
  int type;
  String name;
  List<Gift> gifts;
}

class Gift{
  int giftId; // 礼物
  String giftName; // 礼物名称
  String giftIcon; // 礼物图标
  int selectedIndex; // 选中状态
  int giftType; // 礼物分类

  Gift.from(this.giftId,this.giftName,this.giftIcon,this.selectedIndex,this.giftType);
}
