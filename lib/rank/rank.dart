import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zz_live/rank/rank_item.dart';
import 'package:zz_live/serve/app_data_model.dart';
import 'package:zz_live/serve/rank_serve.dart';

class RankView extends StatefulWidget {
  @override
  _RankViewState createState() => _RankViewState();
}

class _RankViewState extends State<RankView> {
  List<UserInfo> _infos = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    RankServe().getWeekRank(1).then((value) {
      setState(() {
        _infos.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rank"),
      ),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: _infos.length,
          itemBuilder: (ctx, index) {
            var user = _infos[index];
            return RankItem(user, index + 1);
          }),
    );
  }
}
