import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zz_live/home/home_item.dart';
import 'package:zz_live/live/live.dart';
import 'package:zz_live/serve/app_data_model.dart';
import 'package:zz_live/serve/home_serve.dart';

class HomeLiveView extends StatefulWidget {
  @override
  _HomeLiveViewState createState() => _HomeLiveViewState();
}

class _HomeLiveViewState extends State<HomeLiveView> {
  // 主播数据
  List<Anchor> anchorList = [];
  // 切换大小图
  int _rowCount = 2;
  // 当前页
  int _page = 1;
  // 监听滑动
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    getAnchorListData();

    // 监听网络滚动
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
          _page += 1;
          getAnchorListData();
      }
    });
  }

  // 获取主播数据
  void getAnchorListData() {
    HomeServe().homeListData(_page).then((value) {
      setState(() {
        anchorList.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: GridView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(5),
          itemCount: anchorList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _rowCount, //横轴三个子widget
            childAspectRatio: 1, //宽高比为1时，子widget
          ),
          itemBuilder: (ctx, index) {
            final anchor = anchorList[index];
            return HomeItem(anchor,(){
              print("------- object");
              Navigator.push(context, MaterialPageRoute(builder: (_){
               return LiveRoom.from(anchorList,index,_page);
              }));
            });
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(_rowCount == 1 ? Icons.menu : Icons.apps),
        onPressed: () {
          setState(() {
            _rowCount = _rowCount == 1 ? 2 : 1;
          });
        },
      ),
    );
  }
}
