import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  const PageScaffold({Key? key, required this.title, required this.body}) : super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
    );
  }
}

class PageInfo {
  PageInfo(this.title, this.builder, [this.withScaffold = true]);

  String title;
  WidgetBuilder builder;
  bool withScaffold;
}

class ListPage extends StatelessWidget {
  ListPage(this.children);

  final List<PageInfo> children;

  @override
  Widget build(BuildContext context) {
    return ListView(children: _generateItem(context));
  }

  void _openPage(BuildContext context, PageInfo page) {
    //CupertinoPageRoute
    //MaterialPageRoute
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      if (!page.withScaffold) {
        return page.builder(context);
      }
      return PageScaffold(title: page.title, body: page.builder(context));
    }));
  }

  List<Widget> _generateItem(BuildContext context) {
    return children.map<Widget>((page) {
      return ListTile(
        title: Text(page.title),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () => _openPage(context, page),
      );
    }).toList();
  }
}
