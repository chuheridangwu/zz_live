import 'package:dio/dio.dart';

class HttpConfig {
  static const baseUrl = "https://api.huangzewei.me";
  static const timeout = 5000;
}

class HttpRequrst {
  static final Dio _dio = Dio();

// 使用泛型方便查看返回结果
  static Future<T> request<T>(
    String path, {
    String method = "get",
    Map<String, dynamic> params,
    Options options,
    Interceptor inter,
  }) async {

  final option = Options(method: method);
  if (options != null) {
    option.headers = options.headers;
  } 

    // 全局拦截器
    //  Interceptor dInter = InterceptorsWrapper(
    //    onRequest: (options,handler){
    //      print("拦截器 onRequest");
    //      return options;
    //    },
    //    onResponse: (response,handler){
    //      print("拦截器 onResponse");
    //      return response;
    //    },
    //    onError: (err,handler){
    //      print("拦截器 onError");
    //      return err;
    //    }

    //  );
    //  List<Interceptor> inters = [dInter];
    //  if (inter!=null) {
    //    inters.add(inter);
    //  }
    //  _dio.interceptors.addAll(inters);

    // 发送网络请求
    try {
      Response response = await _dio.request(path, options: option);
      // 打印当前结果
      print("当前请求接口是:$path\n返回结果是:${response.data}");
      // 返回请求结果
      return response.data;
    } on DioError catch (e) {
      print("当前请求的URL = $path \n 失败信息 $e");
      return Future.error(e);
    }
  }
}

/*

// 直播列表
https://api.95xiu.com/show/anchor_list_v4.php?address=no%20anthorize&area_id=11&channel=i300585&client_code_version=8&client_side=3&device_id=D2xJC4ZYKQt3Dsq%2BTkqDNH7YtPAIoM3%2FYiu%2FVoHhrFT3oX4e&device_type=iPhone12%2C1&idfa=EFFF1D7E-2F44-4F32-B1A7-A9F200FFF77B&imei=B579FE8C-5F2C-4110-912E-5DB314394D95&is_intl_pack=0&is_qiye=0&isresssxapp=YImh89YJ&packname=mm.live.ios.cn&page_index=1&project_type=3&session_id=64cd33bd3d3aaa25c3fd9717626f219b&type=9&uid=159340708&version=1&version_code=94004

// 推荐列表
https://api.95xiu.com/show/anchor_list_v4.php?address=no%20anthorize&area_id=11&channel=i300585&client_code_version=8&client_side=3&device_id=D2xJC4ZYKQt3Dsq%2BTkqDNH7YtPAIoM3%2FYiu%2FVoHhrFT3oX4e&device_type=iPhone12%2C1&idfa=EFFF1D7E-2F44-4F32-B1A7-A9F200FFF77B&imei=B579FE8C-5F2C-4110-912E-5DB314394D95&is_intl_pack=0&is_qiye=0&isresssxapp=YImh89YJ&packname=mm.live.ios.cn&page_index=0&project_type=3&session_id=64cd33bd3d3aaa25c3fd9717626f219b&type=21&uid=159340708&version=1&version_code=94004

// 礼物列表
https://api.95xiu.com/gift/update_giftv6.php?address=no%20anthorize&channel=i300585&client_code_version=8&client_side=3&device_id=D2xJC4ZYKQt3Dsq%2BTkqDNH7YtPAIoM3%2FYiu%2FVoHhrFT3oX4e&device_type=iPhone12%2C1&faceu_support=1&idfa=EFFF1D7E-2F44-4F32-B1A7-A9F200FFF77B&imei=B579FE8C-5F2C-4110-912E-5DB314394D95&is_intl_pack=0&is_qiye=0&isresssxapp=YImh89YJ&packname=mm.live.ios.cn&session_id=64cd33bd3d3aaa25c3fd9717626f219b&uid=159340708&version_code=94004

// 短视频列表
https://api.95xiu.com/app/shortvideo/short_video.php?address=no%20anthorize&channel=i300585&client_code_version=8&client_side=3&device_id=D2xJC4ZYKQt3Dsq%2BTkqDNH7YtPAIoM3%2FYiu%2FVoHhrFT3oX4e&device_type=iPhone12%2C1&idfa=EFFF1D7E-2F44-4F32-B1A7-A9F200FFF77B&imei=B579FE8C-5F2C-4110-912E-5DB314394D95&is_intl_pack=0&is_qiye=0&isresssxapp=YImh89YJ&packname=mm.live.ios.cn&page=0&session_id=64cd33bd3d3aaa25c3fd9717626f219b&uid=159340708&version_code=94004

// 短视频地址
https://api.95xiu.com/app/shortvideo/browse_video.php?address=no%20anthorize&anchor_id=160595133&channel=i300585&client_code_version=8&client_side=3&device_id=D2xJC4ZYKQt3Dsq%2BTkqDNH7YtPAIoM3%2FYiu%2FVoHhrFT3oX4e&device_type=iPhone12%2C1&idfa=EFFF1D7E-2F44-4F32-B1A7-A9F200FFF77B&imei=B579FE8C-5F2C-4110-912E-5DB314394D95&is_intl_pack=0&is_qiye=0&isresssxapp=YImh89YJ&packname=mm.live.ios.cn&session_id=64cd33bd3d3aaa25c3fd9717626f219b&uid=159340708&version_code=94004&video_id=44271

// 女周星榜
https://api.95xiu.com/app/anchorguard/guard_rank.php?address=no%20anthorize&channel=i300585&client_code_version=8&client_side=3&device_id=D2xJC4ZYKQt3Dsq%2BTkqDNH7YtPAIoM3%2FYiu%2FVoHhrFT3oX4e&device_type=iPhone12%2C1&idfa=EFFF1D7E-2F44-4F32-B1A7-A9F200FFF77B&imei=B579FE8C-5F2C-4110-912E-5DB314394D95&is_intl_pack=0&is_qiye=0&isresssxapp=YImh89YJ&packname=mm.live.ios.cn&session_id=64cd33bd3d3aaa25c3fd9717626f219b&time_passage=2&type=2&uid=159340708&version_code=94004

// 男周星榜
https://api.95xiu.com/app/anchorguard/guard_rank.php?address=no%20anthorize&channel=i300585&client_code_version=8&client_side=3&device_id=D2xJC4ZYKQt3Dsq%2BTkqDNH7YtPAIoM3%2FYiu%2FVoHhrFT3oX4e&device_type=iPhone12%2C1&idfa=EFFF1D7E-2F44-4F32-B1A7-A9F200FFF77B&imei=B579FE8C-5F2C-4110-912E-5DB314394D95&is_intl_pack=0&is_qiye=0&isresssxapp=YImh89YJ&packname=mm.live.ios.cn&session_id=64cd33bd3d3aaa25c3fd9717626f219b&time_passage=2&type=1&uid=159340708&version_code=94004

// 个人信息
https://api.95xiu.com/myprofile/profileinfo.php?address=no%20anthorize&channel=i300585&client_code_version=8&client_side=3&device_id=D2xJC4ZYKQt3Dsq%2BTkqDNH7YtPAIoM3%2FYiu%2FVoHhrFT3oX4e&device_type=iPhone12%2C1&idfa=EFFF1D7E-2F44-4F32-B1A7-A9F200FFF77B&imei=B579FE8C-5F2C-4110-912E-5DB314394D95&is_intl_pack=0&is_qiye=0&isresssxapp=YImh89YJ&packname=mm.live.ios.cn&session_id=64cd33bd3d3aaa25c3fd9717626f219b&uid=146219406&version_code=94004
 
 

//妩媚直播  直播列表 PHPSESSID=obv21di2iuv1phmdi64kueinf7, uid=38216345
https://app.guojiang.tv/room/getRooms?platform=iphone&version=6.3.8&packageId=6&bundleId=tv.xingguang.mingtian&status=2&hasHot=0&page=1&new_user=1&limit=20

 */