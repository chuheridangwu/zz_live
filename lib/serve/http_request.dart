import 'package:dio/dio.dart';

class HttpConfig{
  static const baseUrl = "https://api.huangzewei.me";
  static const  timeout = 5000;
}

class HttpRequrst{

static final Dio _dio = Dio();

// 使用泛型方便查看返回结果
 static Future<T> request<T>(String path,{
   String method = "get",
   Map<String,dynamic> params,
   BaseOptions options,
   Interceptor inter,
   }) async {
   
   // 配置请求头
   final options = Options(method: method);

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
       Response response = await _dio.request(path,options: options);
      // 返回请求结果
      return response.data;
   } on DioError catch (e) {
     print(e);
     return Future.error(e);
   } 

 }

}

/*

// 直播列表
https://api.huangzewei.me/v1/live/stream/list?BSID=1771159533&BVER=8.5.4.2233&SSID=0&app=4&build=18E212&bundle_id=com.remix.miaomiao&count=20&did=43cba54fd9fb4731b208e152e0f5c7f2&lan=0&locale=zh-Hans_JP&mod=iPhone10%2C4&net=ReachableViaWiFi&os_and_version=iOS%2014.5.1&page=1&rdid=00000000-0000-0000-0000-000000000000&sdk=8.5.4&sig=478522c1fb2a2698a5f16913db25916b&source=2&source_id=358760294882794721&sys=ios_14.5.1&token=83e7dfc9e999b99ecc1c3efede940d5b&ts=1621045448668&ver=8.5.4

// 最新的直播列表
https://api.huangzewei.me/v1/live/stream/newest_list?BSID=1771159533&BVER=8.5.4.2233&SSID=0&app=4&build=18E212&bundle_id=com.remix.miaomiao&count=20&did=43cba54fd9fb4731b208e152e0f5c7f2&lan=0&locale=zh-Hans_JP&mod=iPhone10%2C4&net=ReachableViaWiFi&os_and_version=iOS%2014.5.1&page=1&rdid=00000000-0000-0000-0000-000000000000&sdk=8.5.4&sig=1ab345bee8b9b76e4be8ea4c720328a8&source=2&source_id=358760294882794721&sys=ios_14.5.1&token=83e7dfc9e999b99ecc1c3efede940d5b&ts=1621045815050&ver=8.5.4

// 送礼物周榜
https://live.huangzewei.me/coupon/send/rank/week?BSID=1771159533&BVER=8.5.4.2233&SSID=0&app=4&build=18E212&bundle_id=com.remix.miaomiao&count=10&did=43cba54fd9fb4731b208e152e0f5c7f2&lan=0&locale=zh-Hans_JP&mod=iPhone10%2C4&net=ReachableViaWiFi&os_and_version=iOS%2014.5.1&page=1&rdid=00000000-0000-0000-0000-000000000000&sdk=8.5.4&sig=f4c5e0eb67eb5f9db766238a82fde12c&source=2&source_id=358760294882794721&sys=ios_14.5.1&token=83e7dfc9e999b99ecc1c3efede940d5b&ts=1621045968322&ver=8.5.4

// 收礼物周榜
https://live.huangzewei.me/coupon/receive/rank/week?BSID=1771159533&BVER=8.5.4.2233&SSID=0&app=4&build=18E212&bundle_id=com.remix.miaomiao&count=10&did=43cba54fd9fb4731b208e152e0f5c7f2&lan=0&locale=zh-Hans_JP&mod=iPhone10%2C4&net=ReachableViaWiFi&os_and_version=iOS%2014.5.1&page=1&rdid=00000000-0000-0000-0000-000000000000&sdk=8.5.4&sig=9df238cf16cdf17a22469e6873f0adff&source=2&source_id=358760294882794721&sys=ios_14.5.1&token=83e7dfc9e999b99ecc1c3efede940d5b&ts=1621045990124&ver=8.5.4

//动态 精选视频
https://api.huangzewei.me/v1/feed/index_alpha?BSID=1771159533&BVER=8.5.4.2233&SSID=0&app=4&build=18E212&bundle_id=com.remix.miaomiao&did=43cba54fd9fb4731b208e152e0f5c7f2&lan=0&locale=zh-Hans_JP&mod=iPhone10%2C4&net=ReachableViaWiFi&order=inc&os_and_version=iOS%2014.5.1&rdid=00000000-0000-0000-0000-000000000000&score=0&sdk=8.5.4&sig=93f1cf28bc401278483b1e8f6287d6a9&source=2&source_id=358760294882794721&sys=ios_14.5.1&token=83e7dfc9e999b99ecc1c3efede940d5b&ts=1621046328308&ver=8.5.4

// 动态 随机视频
https://api.huangzewei.me/v1/feed/recommend?BSID=1771159533&BVER=8.5.4.2233&SSID=0&app=4&build=18E212&bundle_id=com.remix.miaomiao&count=11&did=43cba54fd9fb4731b208e152e0f5c7f2&lan=0&lat=&locale=zh-Hans_JP&lon=&mod=iPhone10%2C4&net=ReachableViaWiFi&os_and_version=iOS%2014.5.1&page=1&rdid=00000000-0000-0000-0000-000000000000&recommend=0&sdk=8.5.4&sig=7bbb42e5ffe8e9e67c42b9efa56c4df5&source=2&source_id=358760294882794721&sys=ios_14.5.1&token=83e7dfc9e999b99ecc1c3efede940d5b&ts=1621046492863&ver=8.5.4

// 获取个人信息
https://api.huangzewei.me/v1/user/349902936970682009?BSID=1771159533&BVER=8.5.4.2233&SSID=0&app=4&build=18E212&bundle_id=com.remix.miaomiao&did=43cba54fd9fb4731b208e152e0f5c7f2&lan=0&locale=zh-Hans_JP&mod=iPhone10%2C4&net=ReachableViaWiFi&os_and_version=iOS%2014.5.1&rdid=00000000-0000-0000-0000-000000000000&sdk=8.5.4&sig=edb0d8e0e1ba0184e5e707cf844cd61f&source=2&source_id=358760294882794721&sys=ios_14.5.1&token=83e7dfc9e999b99ecc1c3efede940d5b&ts=1621046560303&ver=8.5.4

 */