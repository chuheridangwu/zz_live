import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:zz_live/serve/app_data_model.dart';
import 'package:zz_live/serve/http_request.dart';

class HomeServe{
  int total = 3;
  Future<List<Anchor>> homeListData(int page) async{
    if (page > total) {
      return [];
    }
   String url = "https://app.guojiang.tv/room/getRooms?platform=iphone&version=6.3.8&packageId=6&bundleId=tv.xingguang.mingtian&status=2&hasHot=0&page=${page}&new_user=1&limit=20";

    //网络请求
    List<Anchor>  infos = [];
    
    var result = await HttpRequrst.request(url,method: "post",options: Options(headers: {"cookie":"uid=38216345; PHPSESSID=obv21di2iuv1phmdi64kueinf7"}));
    Map<String,dynamic> mapData = jsonDecode(result);
    if (mapData["errno"] == 0) {
          for (var item in mapData["data"]) {
            var name = item["nickname"];
            var header = item["headPic"];
            var level = item["moderatorLevel"];
            var uid = item["rid"];
            var coins = Random().nextInt(100000);
            var num = Random().nextInt(10000);
          var flv = item["videoPlayFlv"];

            var user = Anchor(flv,num,name,header,level,uid,coins);
            infos.add(user);
          }
    }

    return  infos;
  }
}
