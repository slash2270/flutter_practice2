import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widget/vector_icons_widget.dart';
import '../widget/vector_search_delegate_widget.dart';

class ThirtyThreePage extends StatefulWidget {
  const ThirtyThreePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThirtyThreePageState();
  }
}

class ThirtyThreePageState extends State<ThirtyThreePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThirtyThree Page'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              await showSearch<String?>(
                context: context,
                delegate: VectorSearchDelegateWidget(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.code),
            tooltip: 'Source Code',
            onPressed: () {
              launch('https://github.com/pd4d10/flutter-vector-icons');
            },
          )
        ],
      ),
      body: const VectorIconsWidget(null),
      resizeToAvoidBottomInset: false,
    );
  }

}