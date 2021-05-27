//  https://api.95xiu.com/app/shortvideo/short_video.php?address=no%20anthorize&channel=i300585&client_code_version=8&client_side=3&device_id=D2xJC4ZYKQt3Dsq%2BTkqDNH7YtPAIoM3%2FYiu%2FVoHhrFT3oX4e&device_type=iPhone12%2C1&idfa=EFFF1D7E-2F44-4F32-B1A7-A9F200FFF77B&imei=B579FE8C-5F2C-4110-912E-5DB314394D95&is_intl_pack=0&is_qiye=0&isresssxapp=YImh89YJ&packname=mm.live.ios.cn&page=0&session_id=64cd33bd3d3aaa25c3fd9717626f219b&uid=159340708&version_code=94004
import 'dart:convert';
import 'dart:math';

import 'package:zz_live/serve/app_data_model.dart';

import 'http_request.dart';

class VideoServe {
  int total = 8;

  Future<List<Anchor>> videoListData(int page) async {
    if (page > total) {
      return [];
    }

    String url =
        "https://api.95xiu.com/app/shortvideo/short_video.php?address=no%20anthorize&channel=i300585&client_code_version=8&client_side=3&device_id=D2xJC4ZYKQt3Dsq%2BTkqDNH7YtPAIoM3%2FYiu%2FVoHhrFT3oX4e&device_type=iPhone11%2C1&idfa=EEFF1D7E-2F00-4F32-B1A7-A9F200FFF77B&imei=B579FE80-5F2C-4110-012E-5DB314394000&is_intl_pack=0&is_qiye=0&isresssxapp=YImh89YJ&packname=mm.live.ios.cn&page=$page&session_id=64cd33bd3d3aaa25c3fd9717626f219b&uid=159340708&version_code=94004";

    //网络请求
    List<Anchor> infos = [];

    var result = await HttpRequrst.request(url);

    ///先将String类型数据json编码为Map数据
    Map<String, dynamic> mapData = jsonDecode(result);
    if (mapData["result"] == 1) {
      for (Map item in mapData["videoList"]) {
        var name = item["nick_name"];
        var header = item["path_image"];
        var level = Random().nextInt(13);
        var uid = int.parse(item["uid"]);
        var coins = Random().nextInt(100000);
        var num = Random().nextInt(10000);
        var flv = item["path"];
        var size = item["size"].split("x");
        var width = int.parse(size[0]);
        var height = int.parse(size[1]);

        var user = Anchor(flv, num, name, header, level, uid, coins,
            width: width, height: height);
        infos.add(user);
      }
    }
    return infos;
  }
}
