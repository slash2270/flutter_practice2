import 'package:flutter/material.dart';
import 'package:pimp_my_button/pimp_my_button.dart';

class PimpMyButtonDemo extends StatefulWidget {
  const PimpMyButtonDemo({Key? key}) : super(key: key);

  @override
  _PimpMyButtonDemoState createState() => _PimpMyButtonDemoState();
}

class _PimpMyButtonDemoState extends State<PimpMyButtonDemo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pimp My Button Demo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: PimpedButton(
                        particle: DemoParticle(),
                        pimpedWidgetBuilder: (context, controller) {
                          return FloatingActionButton(onPressed: () {
                            controller.forward(from: 0.0);
                          },);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: PimpedButton(
                        particle: RectangleDemoParticle(),
                        pimpedWidgetBuilder: (context, controller) {
                          return RaisedButton(onPressed: () {
                            controller.forward(from: 0.0);
                          },
                            child: const Text("特別1"),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: PimpedButton(
                        particle: Rectangle2DemoParticle(),
                        pimpedWidgetBuilder: (context, controller) {
                          return MaterialButton(onPressed: () {
                            controller.forward(from: 0.0);
                          },
                            child: const Text("特別2"),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PimpedButton(
              particle: ListTileDemoParticle(),
              pimpedWidgetBuilder: (context, controller) {
                return ListTile(
                  title: const Text("List Title"),
                  subtitle: const Text("List Subtitle"),
                  trailing: const Icon(Icons.add),
                  onTap: () {
                    controller.forward(from: 0.0);
                  },
                );
              },
            ),
            Center(
              child: PimpedButton(
                particle: Rectangle2DemoParticle(),
                pimpedWidgetBuilder: (context, controller) {
                  return IconButton(
                    icon: const Icon(Icons.favorite_border),
                    color: Colors.indigo,
                    onPressed: () {
                      controller.forward(from: 0.0);
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: Center(
                child: PimpedButton(
                  particle: Rectangle3DemoParticle(),
                  pimpedWidgetBuilder: (context, controller) {
                    return RaisedButton(onPressed: () {
                      controller.forward(from: 0.0);
                    },
                      child: const Text("矩形"),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}