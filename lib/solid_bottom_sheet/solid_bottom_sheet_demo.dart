import 'package:flutter/material.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class SolidBottomSheetWidget extends StatefulWidget {
  const SolidBottomSheetWidget({Key? key}) : super(key: key);

  @override
  _SolidBottomSheetWidgetState createState() => _SolidBottomSheetWidgetState();
}

class _SolidBottomSheetWidgetState extends State<SolidBottomSheetWidget> {
  final SolidController _controller = SolidController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solid bottom sheet example"),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Image.asset("assets/cardImg.png"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Flutter rules?",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                /*ButtonTheme.bar(
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('NOPE'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      FlatButton(
                        child: const Text('YEAH'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          );
        },
      ),
      bottomSheet: SolidBottomSheet(
        controller: _controller,
        draggableBody: true,
        headerBar: Container(
          color: Theme.of(context).primaryColor,
          height: 50,
          child: const Center(
            child: Text("Swipe me!"),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: 30,
          child: Center(
            child: Text(
              "Hello! I'm a bottom sheet :D",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.stars),
          onPressed: () {
            _controller.isOpened ? _controller.hide() : _controller.show();
          }),
    );
  }
}