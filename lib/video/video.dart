import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zz_live/home/home_item.dart';
import 'package:zz_live/live/live.dart';
import 'package:zz_live/serve/app_data_model.dart';
import 'package:zz_live/serve/video_serve.dart';

class VideoListView extends StatefulWidget {
  @override
  _VideoListViewState createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {

    // 主播数据
  List<Anchor> anchorList = [];
  // 当前页
  int _page = 1;
  // 监听滑动
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

   void _onRefresh() {
    setState(() {
      _page = 1;
    });
    getAnchorListData();
  }

  void _onLoading() async {
    setState(() {
      _page += 1;
      getAnchorListData();
    });
  }

  // 获取主播数据
  void getAnchorListData() {
    VideoServe().videoListData(_page).then((value) {
      setState(() {
        if (_page == 1) {
          anchorList = [];
        }
        anchorList.addAll(value);
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          header: WaterDropHeader(),
          footer: ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
          ),
          controller: _refreshController,
          child: gardViewWidget()),
    );
  }

  // 卡片View
  Widget gardViewWidget() {
    return GridView.builder(
        padding: EdgeInsets.all(5),
        itemCount: anchorList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //横轴三个子widget
          childAspectRatio: 1, //宽高比为1时，子widget
        ),
        itemBuilder: (ctx, index) {
          final anchor = anchorList[index];
          return HomeItem(anchor, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return LiveRoom.from(anchorList, index, _page);
            }));
          });
        });
  }

}