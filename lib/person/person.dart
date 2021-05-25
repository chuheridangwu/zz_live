import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zz_live/live/gift_item.dart';
import 'package:zz_live/live/gift_list_view.dart';
import 'package:zz_live/live/gift_manager.dart';

class PersonView extends StatefulWidget {
  @override
  _PersonViewState createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView>{
  List<GiftGroup> _giftGroups = [];

  @override
  void initState() {
    super.initState();
    GiftManager.getGiftData().then((List<GiftGroup> value) {
      setState(() {
        _giftGroups = value;
        pageGiftList();
      });
    });

  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: GiftListView(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("data"),
        heroTag: 100,
        onPressed: () {
          
        },
      ),
    );
  }

  // 分类礼物索引
  int _tabIndex = 0;
  List<List<Gift>> _pageGifts = [];

  void pageGiftList() {
    List<Gift> gifts = _giftGroups[_tabIndex].gifts;
    int start = 0;
    int end = 8;
    while (start < gifts.length) {
      end = min(end, gifts.length);
      List<Gift> pages = gifts.sublist(start, end);
      setState(() {
                    _pageGifts.add(pages);
            });
      start += 8;
      end += 8;
    }
  }

}

class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  _TapboxAState createState() => new _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}