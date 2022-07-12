import 'package:flutter/material.dart';
import '../widget/deferredbox.dart' deferred as box;

class DeferredBoxDemo extends StatefulWidget {
  const DeferredBoxDemo({Key? key}) : super(key: key);

  @override
  _DeferredBoxDemoState createState() => _DeferredBoxDemoState();
}

class _DeferredBoxDemoState extends State<DeferredBoxDemo> {
  late Future<void> _libraryFuture;

  @override
  void initState() {
    _libraryFuture = box.loadLibrary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _libraryFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('DeferredBox Error: ${snapshot.error}');
          }
          return box.DeferredBox(title: 'Future\nDeferred',);
        }
        return const CircularProgressIndicator();
      },
    );
  }
}