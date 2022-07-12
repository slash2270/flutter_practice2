import 'package:flutter/material.dart';
import '../widget/deferredbox.dart' deferred as box;
import '../widget/deferredwidget.dart';

class DeferredWidgetDemo extends StatefulWidget {
  const DeferredWidgetDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DeferredWidgetDemoState();
  }
}

class DeferredWidgetDemoState extends State<DeferredWidgetDemo> {

  @override
  Widget build(BuildContext context) {
    return DeferredWidget(() => box.loadLibrary(), () => box.DeferredBox(title: 'Loader\nDeferred',));
  }

}