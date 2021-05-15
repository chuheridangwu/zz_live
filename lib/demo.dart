import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DemoTest extends StatefulWidget {


  @override
  _DemoTestState createState() => _DemoTestState();
}

class _DemoTestState extends State<DemoTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
              width: 200,
              child: MaYiView(width: 5,count: 5,),
            ),
      )
    );
  }
}

class MaYiView extends StatelessWidget {
  final Axis axis;
  final double width;
  final double height;
  final int count;
  final Color color;
  MaYiView({this.axis = Axis.horizontal,this.width = 1,this.height = 1,this.count = 10,this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: axis,
      children: List.generate(count, (_){
        return SizedBox(
          width: width,
          height: height,
          child: DecoratedBox(
            decoration:BoxDecoration(color: color) ,
          ),
        );
      }),);
  }
}


class StartView extends StatefulWidget {

      final double rating;
  final double maxRating;
  final int count;
  final double size;
  final Color unselectedColor;
  final Color selectedColor;
  final Widget unselectedImg;
  final Widget selectedImg;

  StartView({
    @required this.rating,
    this.maxRating = 10,
    this.count = 5,
    this.size = 30,
    this.unselectedColor = Colors.grey,
    this.selectedColor = Colors.red,
    Widget unselectedImg,
    Widget selectedImg
  }) :  unselectedImg  = unselectedImg ??  Icon(Icons.star_border,color: unselectedColor,size: size,),
      selectedImg = selectedImg ?? Icon(Icons.star,color: selectedColor,size: size,)
   ;

  @override
  _StartViewState createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: buildUnStart(),
          ),
          Row(mainAxisSize: MainAxisSize.min,
            children: buildSelStart(),
          )
        ],
      ),
    );
  }

    List<Widget> buildUnStart(){
   return List.generate(widget.count, (index){
       return  widget.unselectedImg;
    });
  }

  List<Widget> buildSelStart(){
    final start = widget.selectedImg;
    // 创建一个数据
    List<Widget> starts = [];
    // 构造满的start
    double oneValue = widget.maxRating / widget.count;
    int entireCount = (widget.rating / oneValue).floor();
    // 创建widget
    for (var i = 0; i < entireCount; i++) {
      starts.add(start);
    }

    // 裁剪的widget
    var leftWidth = ((widget.rating / oneValue) - entireCount) * widget.size;
    var halfStart = ClipRect(child: start,clipper: StartClipper(leftWidth));
    starts.add(halfStart);

    return starts;
  }
}

class StartClipper extends CustomClipper<Rect>{
   double value;
  StartClipper(this.value);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, value, size.height);
  }

  @override
  bool shouldReclip(covariant StartClipper oldClipper) {
    return oldClipper.value != this.value;
  }
  
}


