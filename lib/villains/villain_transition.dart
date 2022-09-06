import 'package:flutter/material.dart';
import 'package:flutter_practice2/villains/villain_util.dart';
import 'package:flutter_villains/villains/utils.dart';
import 'package:flutter_villains/villains/villains.dart';

class VillainGrid extends StatefulWidget {
  const VillainGrid({Key? key}) : super(key: key);

  @override
  _VillainGridState createState() => _VillainGridState();
}

class _VillainGridState extends State<VillainGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Villain Demo"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: Images.imageThumbUrls.map((url) => InkWell(
          child: Hero(tag: url, child: Image.network(url)),
          onTap: () => transition(url),
        ))
            .toList(),
      ),
    );
  }

  void transition(String url) {
    Navigator.of(context).push(
        FadeRoute(VillainDetail(
      url: url,
    )));
  }
}

class VillainDetail extends StatefulWidget {
  const VillainDetail({Key? key, this.url}) : super(key: key);
  final String? url;

  @override
  _VillainDetailState createState() => _VillainDetailState();
}

class _VillainDetailState extends State<VillainDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSizeProxy(
        preferredSizeWidget: AppBar(
          title: const Text("Villain Detail"),
          backgroundColor: Colors.green,
        ),
        widgetWithChildBuilder: (context, child) {
          return Villain(
            villainAnimation: VillainAnimation.fromTop(),
            child: child,
          );
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: widget.url!,
              child: Image.network(widget.url!),
            ),
            Villain(
              villainAnimation: VillainAnimation.fromBottom(),
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Text(
                  "這是一個美麗的形象",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Villain(
        villainAnimation: VillainAnimation.scale(fromScale: 0.7),
        animateExit: false,
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}