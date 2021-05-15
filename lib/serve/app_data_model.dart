class UserInfo{
  final String userName; 
  final String headerIcon;
  final int level; // 等级
  final int coins; // 金币
  UserInfo(this.userName,this.headerIcon,this.level, this.coins);
}

class Anchor extends UserInfo{
  final String liveAddres;  // 直播地址
  final int watchNum; // 观看人数
  Anchor(this.liveAddres,this.watchNum,String userName, String headerIcon, int level,int coins) : super(userName, headerIcon, level, coins);
}