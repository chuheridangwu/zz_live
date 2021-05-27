import 'dart:math';

import 'package:flutter/material.dart';

class PersonView extends StatefulWidget {
  @override
  _PersonViewState createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {

    final GlobalKey<_AnimationDemo01State> demo01Key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimationDemo01(key: demo01Key),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_circle_filled),
        onPressed: () {
          if (!demo01Key.currentState._animationController.isAnimating) {
            demo01Key.currentState._animationController.forward();
          } else {
            demo01Key.currentState._animationController.stop();
          }
        },
      ),
    );
  }
}

class AnimationDemo01 extends StatefulWidget {
  AnimationDemo01({Key key}): super(key: key);

  @override
  _AnimationDemo01State createState() => _AnimationDemo01State();
}

class _AnimationDemo01State extends State<AnimationDemo01> with SingleTickerProviderStateMixin {
    ///动画控制器
  AnimationController _animationController;
  ///旋转弧度动画
  Animation<double> _angleAnimation;
    ///抖动的范围配置
  double _shakeRange = 0.5;
  ///抖动的执行次数
  int  _shakeTotalCount = 20;
 ///当前抖动执行次数
  int _shakeCurrentCount = 0;

  @override
  void initState() {
    super.initState();

    // 1.创建AnimationController
       _animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
     ///2、创建串行动画
    _angleAnimation = TweenSequence<double>([
      ///TweenSequenceItem来组合其他的Tween
      TweenSequenceItem<double>(
          tween: Tween(begin: 0, end: _shakeRange), weight: 1),
      TweenSequenceItem<double>(
          tween: Tween(begin: _shakeRange, end: 0), weight: 2),
      TweenSequenceItem<double>(
          tween: Tween(begin: 0, end: -_shakeRange), weight: 3),
      TweenSequenceItem<double>(
          tween: Tween(begin: -_shakeRange, end: 0), weight: 4),
    ]).animate(_animationController);
    
    // 3.监听动画
    ///添加动画状态监听
    // _angleAnimation.addStatusListener(statusListener);
    // 4.控制动画的翻转
    _animationController.forward();
  }

    ///动画执行状态监听
  void statusListener(status) {
    if (status == AnimationStatus.completed) {
      ///正向执行完毕后立刻反向执行（倒回去）
      _animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      ///无次数限定执行
      if (_shakeTotalCount == 0) {
        ///反向执行完毕后立刻正向执行
        _animationController.forward();
      } else {
        ///有次数限定执行
        if (_shakeCurrentCount < _shakeTotalCount) {
          ///未执行够次数时继续执行
          _animationController.forward();
        } else {
          // if (widget.shakeAnimationController != null) {
          //   widget.shakeAnimationController.animationRunging = false;
          // }
        }

        ///动画执行次数自增
        _shakeCurrentCount++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _angleAnimation, builder: (ctx,widget){
      return Transform(transform: Matrix4.translationValues(0, _angleAnimation.value * 15, 0), child: Icon(Icons.favorite, color: Colors.red,));
    });
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }
}
