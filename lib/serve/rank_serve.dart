import 'package:dio/dio.dart';
import 'package:zz_live/serve/app_data_model.dart';
import 'package:zz_live/serve/http_request.dart';

class RankServe{

int total = 1;

  // 获取送礼周榜
Future<List<UserInfo>> getWeekRank(int page) async {
    var params = {
      "count":"10",
      "page":"1",
      "BSID":"1771159533",
      "BVER":"8.5.4.2233",
      "SSID":"0",
      "app":"4",
      "build":"18E212",
      "bundle_id":"com.remix.miaomiao",
      "did":"43cba54fd9fb4731b208e152e0f5c7f2",
      "lan":"0",
      "locale":"zh-Hans_JP",
      "mod":"iPhone10.2,4",
      "net":"ReachableViaWiFi",
      "rdid":"00000000-0000-0000-0000-000000000000",
      "sdk":"8.5.4",
      "sys":"ios_14.5.1",
      "token":"83e7dfc9e999b99ecc1c3efede940d5b",
      "source_id":"358760294882794721",
      "ver":"8.5.4",
      "ts": DateTime.now().millisecondsSinceEpoch,
      "sig":"9df238cf16cdf17a22469e6873f0adff",
    };

  // 发起网络请求 
  if (page > total) {
    return [];
  }

  List<UserInfo> infos = [];
  var result = await HttpRequrst.request("https://live.huangzewei.me/coupon/receive/rank/week?BSID=1771159533&BVER=8.5.4.2233&SSID=0&app=4&build=18E212&bundle_id=com.remix.miaomiao&count=10&did=43cba54fd9fb4731b208e152e0f5c7f2&lan=0&locale=zh-Hans_JP&mod=iPhone10%2C4&net=ReachableViaWiFi&os_and_version=iOS%2014.5.1&page=${page}&rdid=00000000-0000-0000-0000-000000000000&sdk=8.5.4&sig=9df238cf16cdf17a22469e6873f0adff&source=2&source_id=358760294882794721&sys=ios_14.5.1&token=83e7dfc9e999b99ecc1c3efede940d5b&ts=1621045990124&ver=8.5.4");
  
  total = result["c"];
  var baseUrl = result["t"]["ap"];
  for (Map item in result["f"]) {
    var name = item["n"];
    var header = item["a"];
    var level = item["la"];
    var coins = item["c"];
    
    var user = UserInfo(name,baseUrl + header,level,coins);
    infos.add(user);
  }
  
  return infos;
  }

}