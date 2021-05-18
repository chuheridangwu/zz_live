import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
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
      });
    _videoController.addListener(() {
      if (_videoController.value.isPlaying) {
        print("播放视频 - ${widget.anchor.liveAddres}");
      }
    });
    _videoController.play();
  }

  @override
  void dispose() {
    super.dispose();
    print("视频播放器销毁 - ${widget.anchor.liveAddres}");
    _videoController.removeListener(() {});
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return _videoController.value.isInitialized
        ? Container(
            width: size.width,
            height: size.height,
            child: VideoPlayer(_videoController),
          )
        : Container(
            child: Image.network(
              widget.anchor.headerIcon,
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
            ),
          );
  }
}
