import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class ReoderablesNestedWrapWidget extends StatefulWidget {
  ReoderablesNestedWrapWidget({
    Key? key,
    this.depth = 0,
    this.valuePrefix = '',
    this.color,
  }) : super(key: key);
  final int depth;
  final String valuePrefix;
  final Color? color;
  final List<Widget> _tiles = [];

  @override
  State createState() => _ReoderablesNestedWrapWidgetState();
}

class _ReoderablesNestedWrapWidgetState extends State<ReoderablesNestedWrapWidget> {
//  List<Widget> _tiles;
  Color? _color;
  Color? _colorBrighter;

  @override
  void initState() {
    super.initState();
    _color = widget.color ?? Colors.primaries[widget.depth % Colors.primaries.length];
    _colorBrighter = Color.lerp(_color, Colors.white, 0.6);
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        widget._tiles.insert(newIndex, widget._tiles.removeAt(oldIndex));
      });
    }

    var wrap = ReorderableWrap(
      spacing: 8.0,
      runSpacing: 4.0,
      padding: const EdgeInsets.all(8),
      onReorder: _onReorder,
      onNoReorder: (int index) {
        //這個回調是可選的
        debugPrint('${DateTime.now().toString().substring(5, 22)} 重新訂購已取消。 指數:$index');
      },
      children: widget._tiles,
    );

    var buttonBar = Container(
      color: _colorBrighter,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            iconSize: 42,
            icon: const Icon(Icons.add_circle),
            color: Colors.deepOrange,
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              setState(() {
                widget._tiles.add(
                  Card(
                    color: _colorBrighter,
                    elevation: 3,
                    child: Container(
                      padding: EdgeInsets.all((24.0 / math.sqrt(widget.depth + 1)).roundToDouble()),
                      child: Text('${widget.valuePrefix}${widget._tiles.length}', textScaleFactor: 3 / math.sqrt(widget.depth + 1)),
                    ),
                  )
                );
              });
            },
          ),
          IconButton(
            iconSize: 42,
            icon: const Icon(Icons.remove_circle),
            color: Colors.teal,
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              setState(() {
                widget._tiles.removeAt(0);
              });
            },
          ),
          IconButton(
            iconSize: 42,
            icon: const Icon(Icons.add_to_photos),
            color: Colors.pink,
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              setState(() {
                widget._tiles.add(ReoderablesNestedWrapWidget(depth: widget.depth + 1, valuePrefix: '${widget.valuePrefix}${widget._tiles.length}.',));
              });
            },
          ),
          Text('Level ${widget.depth} / ${widget.valuePrefix}'),
        ],
      )
    );

    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buttonBar,
        wrap,
      ]
    );

    return SingleChildScrollView(
      child: Container(color: _color,child: column,),
    );
  }
}


//main() => runApp(MaterialApp(
//  home: Scaffold(
//    appBar: AppBar(),
//    body: NestedWrapExample(),
//  ),
//));
