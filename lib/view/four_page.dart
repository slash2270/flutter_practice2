import 'package:flutter/material.dart';
import 'package:flutter_practice2/demo/stagger_drawer_demo.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/demo/deferredbox_demo.dart' as deferredBox;
import 'package:flutter_practice2/demo/deferredwidget_demo.dart' as deferredWidget;
import 'package:flutter_practice2/system/flustars_demo.dart' as flustars;
import 'package:flutter_practice2/system/sprintf_demo.dart' as sprint;

class FourPage extends StatefulWidget {
  const FourPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FourPageState();
  }
}

class FourPageState extends State<FourPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    super.initState();
    _functionUtil = FunctionUtil();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: _functionUtil.initText("Four Page"),
        centerTitle: true,
      ),
      body: StaggeredDrawerDemo(
          child: SingleChildScrollView(
            child: Column(
            children: <Widget>[
              _functionUtil.initSizedBox(20.0),
              flustars.FlustarsDemo(),
              _functionUtil.initSizedBox(20.0),
              const sprint.SprintFDemo(),
              _functionUtil.initSizedBox(20.0),
              //const MoneyDemo(),
              _functionUtil.initText2('Deferred 延遲加載', Colors.black, Colors.transparent, 24),
              _functionUtil.initSizedBox(20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  deferredBox.DeferredBoxDemo(),
                  deferredWidget.DeferredWidgetDemo(),
                ],
              ),
              _functionUtil.initSizedBox(20.0),
            ],
          ),
        ),
      )
    );
  }

}