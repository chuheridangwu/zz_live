import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';
import 'package:zz_live/live/gift_list_view.dart';
import 'package:zz_live/live/live_end.dart';
import 'package:zz_live/serve/app_data_model.dart';

// ignore: must_be_immutable
class LiveItem extends StatefulWidget {
  final Anchor anchor;
  LiveItem(this.anchor);
  @override
  _LiveItemState createState() => _LiveItemState();
}

class _LiveItemState extends State<LiveItem> {
  VideoPlayerController _videoController;
  bool _isLiveEnd = false;
  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.anchor.liveAddres)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        print("播放器初始化完成");

        setState(() {});
      }).onError((error, stackTrace) {
        print("播放器播放视频失败 - ${error.toString()}");
        setState(() {
          _isLiveEnd = true;
        });
      });
    _videoController.addListener(() {
      if (_videoController.value.isPlaying) {
        print("播放视频 - ${widget.anchor.liveAddres}");
      } else if (_videoController.value.hasError) {
        setState(() {
          _isLiveEnd = true;
        });
      }
    });
    _videoController.play();
  }

  @override
  void dispose() {
    super.dispose();
    print("视频播放器销毁 - ${widget.anchor.liveAddres}");
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return _isLiveEnd
        ? LiveEndView(widget.anchor)
        : Container(
            width: size.width,
            height: size.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                liveViewWidget(size),
                bottomButtons(),
              ],
            ),
          );
  }

  // 直播界面
  Widget liveViewWidget(Size size) {
    return _videoController.value.isInitialized
        ? VideoPlayer(_videoController)
        : CachedNetworkImage(
            imageUrl: widget.anchor.headerIcon,
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          );
  }

  // 底部按钮widget
  Widget bottomButtons() {
    return Positioned(
        left: 5,
        right: 5,
        bottom: 10,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Image.asset(
                    "images/room/room_public.png",
                  ),
                  onPressed: () {}),
              Expanded(child: Container()),
              IconButton(
                  icon: Image.asset(
                    "images/room/room_gift.png",
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        barrierColor: Colors.black12,
                        backgroundColor: Colors.black12,
                        context: context,
                        builder: (_) {
                          return GiftListView();
                        });
                  }),
              IconButton(
                  icon: Image.asset(
                    "images/room/room_share.png",
                  ),
                  onPressed: () {
                    Share.share('check out my website https://example.com');
                  }),
              IconButton(
                  icon: Image.asset(
                    "images/room/room_close.png",
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ));
  }
}
