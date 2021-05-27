import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:zz_live/live/gift_manager.dart';

// ignore: must_be_immutable
class GiftItem extends StatefulWidget {
  final Gift gift;
  void Function(GiftItem item) callback;

  GiftItem(this.gift, {this.callback});

  @override
  _GiftItemState createState() => _GiftItemState();
}

class _GiftItemState extends State<GiftItem> {
  // 选中礼物的个数
  int _number = 1;

  // 选中其中一个Item
  void _selectedItem() {
    setState(() {
      // 如果重复点击的是一个item
      if (widget.gift.giftId == GiftManager().currentGift.giftId) {
        int index = widget.gift.numbers.indexOf(_number) + 1;
        if (index >= widget.gift.numbers.length) {
          index = 0;
        }
        _number = widget.gift.numbers[index];
      }
      GiftManager().currentGift = widget.gift;
    });
    widget.gift.isSelected = true;
    // 礼物图标抖动
    _shakeAnimationController.start(shakeCount: 1);

    widget.callback(widget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectedItem,
      child: Container(
          padding: EdgeInsets.all(10),
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  right: -5,
                  top: -5,
                  child: widget.gift.isSelected
                      ? Container(
                          height: 12,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          child: Text(
                            "  x$_number  ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        )
                      : Container()),
              Container(
                decoration: widget.gift.isSelected
                    ? BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.all(Radius.circular(5)))
                    : BoxDecoration(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    giftIconWidget(),
                    giftNameWidget(),
                    giftPriceWidget(),
                  ],
                ),
              )
            ],
          )),
    );
  }

  // 顶部图片
  ShakeAnimationController _shakeAnimationController =
      new ShakeAnimationController();
  Widget giftIconWidget() {
    return ShakeAnimationWidget(
        shakeAnimationController: _shakeAnimationController,
        shakeAnimationType: ShakeAnimationType.TopBottomShake,
        isForward: widget.gift.isSelected,
        shakeCount: 1,
        child: CachedNetworkImage(
            imageUrl: widget.gift.giftIcon,
            width: widget.gift.isSelected ? 45 : 40));
  }

  // 礼物名称
  Widget giftNameWidget() {
    return widget.gift.isSelected
        ? Text(widget.gift.giftName,
            style: TextStyle(color: Colors.white, fontSize: 13))
        : SizedBox(
            height: 5,
          );
  }

  // 礼物价格
  Widget giftPriceWidget() {
    return RichText(
        text: TextSpan(children: [
      WidgetSpan(
        child: Icon(
          Icons.star,
          size: 13,
        ),
      ),
      TextSpan(
          text: widget.gift.price,
          style: TextStyle(color: Colors.white, fontSize: 12))
    ]));
  }
}
