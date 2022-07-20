import 'package:flutter/material.dart';
import 'package:flutter_practice2/line/line_api.dart';
import 'line_pay_widget.dart';
import 'line_user.dart';

class LineDemo extends StatelessWidget {
  const LineDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LINE SDK Demo'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'User'),
              Tab(text: 'API'),
              Tab(text: 'Pay'),
            ],
            indicatorColor: null,
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: LineUser(),
            ),
            Center(
              child: LineAPIPage(),
            ),
            Center(
              child: LinePayWidget(),
            ),
          ],
        ),
      ),
    );
  }
}