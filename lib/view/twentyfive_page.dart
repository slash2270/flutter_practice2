
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/constants.dart';

import '../rxdart_github_search/rx_github_api.dart';
import '../rxdart_github_search/rx_search_github_widget.dart';

class TwentyFivePage extends StatefulWidget {
  const TwentyFivePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TwentyFivePageState();
  }
}

class TwentyFivePageState extends State<TwentyFivePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 一个不需要GlobalKey就可以openDrawer的AppBar
      appBar: AppBar(
        title: const Text('TwentyFive Page'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, Constants.routeHome);
            },
          ),
        ],
      ),
      body: RxSearchGithubWidget(api: RxGithubApi()),
      resizeToAvoidBottomInset: false,
    );
  }

}