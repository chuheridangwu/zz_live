import 'package:flutter/material.dart';
import 'package:zz_live/live/live_item.dart';
import 'package:zz_live/serve/app_data_model.dart';
import 'package:zz_live/serve/home_serve.dart';

// ignore: must_be_immutable
class LiveRoom extends StatefulWidget {
  final List<Anchor> rooms;
  int index;
  final int page;

  LiveRoom.from(this.rooms, this.index, this.page);

  @override
  _LiveRoomState createState() => _LiveRoomState();
}

class _LiveRoomState extends State<LiveRoom> {
  var _pageController;
  var isLoadMore = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
  }

  // 滚动视图
  void onPageChangeVlaue(int page) {
    if (page == widget.rooms.length - 1 && isLoadMore) {
      getAnchorListData();
      return;
    }
    widget.index += 1;
  }

  void getAnchorListData() {
    HomeServe().homeListData(widget.page).then((value) {
      setState(() {
        if (value.length == 0) {
          isLoadMore = false;
          widget.index = 0;
          _pageController.jumpToPage(widget.index);
        }
        widget.rooms.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: PageView.builder(
          onPageChanged: onPageChangeVlaue,
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: widget.rooms.length,
          itemBuilder: (ctx, index) {
            final Anchor anchor = widget.rooms[index];
            return LiveItem(anchor);
          }),
    );
  }
}
