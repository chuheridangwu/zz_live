class UserInfo{
  final String userName; 
  final String headerIcon;
  final int uid; // 用户idx
  final int level; // 等级
  final int coins; // 金币
  UserInfo(this.userName,this.headerIcon,this.uid,this.level, this.coins);
}

class Anchor extends UserInfo{
  final String liveAddres;  // 直播地址
  final int watchNum; // 观看人数
  int width;
  int height;
  Anchor(this.liveAddres,this.watchNum,String userName, String headerIcon, int uid,  int level,int coins,{this.width,this.height}) : super(userName, headerIcon, uid, level, coins);
}