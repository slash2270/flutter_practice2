import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../util/constants.dart';
import '../util/function_util.dart';

@immutable
class StickyHeadersDemo extends StatefulWidget {
  const StickyHeadersDemo({Key? key}) : super(key: key);

  @override
  State<StickyHeadersDemo> createState() => _StickyHeadersDemoState();
}

class _StickyHeadersDemoState extends State<StickyHeadersDemo> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
        delegate: SliverChildListDelegate(
          [
            ListTile(
              title: const Text('Widget 1 - Headers and Content', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
              onTap: () => _functionUtil.navigateTo(context, (context) => const StickyHeadersWidget1()),
            ),
            ListTile(
              title: const Text('Widget 2 - Animated Headers with Content', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
              onTap: () => _functionUtil.navigateTo(context, (context) => const StickyHeadersWidget2()),
            ),
            ListTile(
              title: const Text('Widget 3 - Headers overlapping the Content', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
              onTap: () => _functionUtil.navigateTo(context, (context) => const StickyHeadersWidget3()),
            ),
            ListTile(
              title: const Text('Widget 4 - Example using scroll controller', style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent, fontSize: 17), textAlign: TextAlign.center,),
              onTap: () => _functionUtil.navigateTo(context, (context) => const StickyHeadersWidget4()),
            ),
          ].toList(growable: false),
        ), itemExtent: 50.0,
    );
  }

}

@immutable
class StickyHeadersWidget1 extends StatelessWidget {
  const StickyHeadersWidget1({Key? key, this.controller,}) : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      wrap: controller == null,
      title: 'StickyHeadersWidget 1',
      child: ListView.builder(
        primary: controller == null,
        controller: controller,
        itemBuilder: (context, index) {
          return StickyHeader(
            controller: controller, // Optional
            header: Container(
              height: 50.0,
              color: Colors.blueGrey[700],
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Header #$index',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            content: Container(
              color: Colors.grey[300],
              child: Image.network(
                imageForIndex(index),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
            ),
          );
        },
      ),
    );
  }

  String imageForIndex(int index) {
    return Constants.imageThumbUrls[index % Constants.imageThumbUrls.length];
  }
}

@immutable
class StickyHeadersWidget2 extends StatelessWidget {
  const StickyHeadersWidget2({Key? key, this.controller,}) : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      wrap: controller == null,
      title: 'StickyHeadersWidget 2',
      child: ListView.builder(
        primary: controller == null,
        controller: controller,
        itemBuilder: (context, index) {
          return StickyHeaderBuilder(
            controller: controller, // Optional
            builder: (BuildContext context, double stuckAmount) {
              stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
              return Container(
                height: 50.0,
                color: Color.lerp(Colors.blue[700], Colors.red[700], stuckAmount),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Header #$index',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Offstage(
                      offstage: stuckAmount <= 0.0,
                      child: Opacity(
                        opacity: stuckAmount,
                        child: IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.white),
                          onPressed: () => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Favorite #$index'))),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            content: Container(
              color: Colors.grey[300],
              child: Image.network(
                imageForIndex(index),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
            ),
          );
        },
      ),
    );
  }

  String imageForIndex(int index) {
    return Constants.imageThumbUrls[index % Constants.imageThumbUrls.length];
  }
}

@immutable
class StickyHeadersWidget3 extends StatelessWidget {
  const StickyHeadersWidget3({Key? key, this.controller,}) : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      wrap: controller == null,
      title: 'StickyHeadersWidget 3',
      child: ListView.builder(
        primary: controller == null,
        controller: controller,
        itemBuilder: (context, index) {
          return StickyHeaderBuilder(
            overlapHeaders: true,
            controller: controller, // Optional
            builder: (BuildContext context, double stuckAmount) {
              stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
              return Container(
                height: 50.0,
                color: Colors.grey.shade900.withOpacity(0.6 + stuckAmount * 0.4),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Header #$index',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
            content: Container(
              color: Colors.grey[300],
              child: Image.network(
                imageForIndex(index),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
            ),
          );
        },
      ),
    );
  }

  String imageForIndex(int index) {
    return Constants.imageThumbUrls[index % Constants.imageThumbUrls.length];
  }
}

@immutable
class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper({
    Key? key,
    required this.title,
    required this.child,
    this.wrap = true,
  }) : super(key: key);

  final Widget child;
  final String title;
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    if (wrap) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Hero(
            tag: 'app_bar',
            child: AppBar(
              title: Text(title),
              elevation: 0.0,
            ),
          ),
        ),
        body: child,
      );
    } else {
      return Material(
        child: child,
      );
    }
  }
}

@immutable
class StickyHeadersWidget4 extends StatefulWidget {
  const StickyHeadersWidget4({Key? key}) : super(key: key);

  @override
  State<StickyHeadersWidget4> createState() => _StickyHeadersWidget4State();
}

class _StickyHeadersWidget4State extends State<StickyHeadersWidget4> {
  late final _controller = List.generate(4, (_) => ScrollController());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: _controller[0],
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text('StickyHeadersWidget 4'),
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                bottom: const TabBar(
                  tabs: <Tab>[
                    Tab(text: 'StickyHeadersWidget 1'),
                    Tab(text: 'StickyHeadersWidget 2'),
                    Tab(text: 'StickyHeadersWidget 3'),
                  ],
                ),
              ),
            ];
          },
          body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: TabBarView(
              children: <Widget>[
                StickyHeadersWidget1(controller: _controller[1]),
                StickyHeadersWidget2(controller: _controller[2]),
                StickyHeadersWidget3(controller: _controller[3]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}