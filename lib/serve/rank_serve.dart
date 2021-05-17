import 'dart:convert';
import 'package:zz_live/serve/app_data_model.dart';
import 'package:zz_live/serve/http_request.dart';

class RankServe{

// 总页数
int total = 1;

  // 获取送礼周榜
Future<List<UserInfo>> getWeekRank(int page) async {

  // 发起网络请求 
  if (page > total) {
    return [];
  }

  List<UserInfo> infos = [];
  var result = await HttpRequrst.request("https://api.95xiu.com/app/anchorguard/guard_rank.php?address=no%20anthorize&channel=i300585&client_code_version=8&client_side=3&device_id=D2xJC4ZYKQt3Dsq%2BTkqDNH7YtPAIoM3%2FYiu%2FVoHhrFT3oX4e&device_type=iPhone11,2C1&idfa=0000000-0000-0000-0000-000000000&imei=0000000-0000-0000-0000-000000000&is_intl_pack=0&is_qiye=0&isresssxapp=YImh89YJ&packname=mm.live.ios.cn&session_id=64cd33bd3d3aaa25c3fd9717626f219b&time_passage=2&type=2&uid=159340703&version_code=94004");
  ///先将String类型数据json编码为Map数据
  Map<String, dynamic> mapData =  jsonDecode(result);
  for (Map item in mapData["data"]) {
    var name = item["nickname"];
    var header = item["head_image"];
    var level = item["star_level"];
    var uid = int.parse(item["uid"]);
    var coins = int.parse(item["star_integral"]);
    
    var user = UserInfo(name,header,uid,level,coins);
    infos.add(user);
  }
  
  return infos;
  }

}