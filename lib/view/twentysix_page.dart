
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/redux_github_search/redux_github_search_widget.dart';
import 'package:flutter_practice2/util/constants.dart';

class TwentySixPage extends StatefulWidget {
  const TwentySixPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TwentySixPageState();
  }
}

class TwentySixPageState extends State<TwentySixPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 一个不需要GlobalKey就可以openDrawer的AppBar
      appBar: AppBar(
        title: const Text('TwentySix Page'),
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
      body: const ReduxGithubSearchWidget(),
      resizeToAvoidBottomInset: false,
    );
  }

}