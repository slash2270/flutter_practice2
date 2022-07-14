import 'package:flutter/material.dart';
import 'package:full_screen_menu/full_screen_menu.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({required this.iconData, required this.text});
  IconData iconData;
  String text;
}

class FABBottomAppBarWidget extends StatefulWidget {
  FABBottomAppBarWidget ({Key? key,
    required this.items,
    required this.centerItemText,
    this.height = 60.0,
    this.iconSize = 24.0,
    required this.backgroundColor,
    required this.color,
    required this.selectedColor,
    required this.notchedShape,
    required this.onTabSelected,
  }) : super(key: key) {
    assert(items.length == 2 || items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarWidgetState();
}

class FABBottomAppBarWidgetState extends State<FABBottomAppBarWidget> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      color: widget.backgroundColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: widget.iconSize),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    item.text,
                    style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showFullScreenMenu(BuildContext context) {
  FullScreenMenu.show(
    context,
    backgroundColor: Colors.black,
    items: [
      FSMenuItem(
        icon: const Icon(Icons.ac_unit, color: Colors.white),
        text: const Text('更冷', style: TextStyle(color: Colors.white)),
        gradient: blueGradient,
        onTap: () {
          print('Made Ukraine colder!');
        },
      ),
      FSMenuItem(
        icon: const Icon(Icons.wb_sunny, color: Colors.white),
        text: const Text('更熱', style: TextStyle(color: Colors.white)),
        gradient: redGradient,
      ),
      FSMenuItem(
        icon: const Icon(Icons.flash_on, color: Colors.white),
        text: const Text('閃電', style: TextStyle(color: Colors.white)),
        gradient: orangeGradient,
      ),
      FSMenuItem(
        icon: const Icon(Icons.grain, color: Colors.white),
        text: const Text('給一場雨', style: TextStyle(color: Colors.white)),
        gradient: deepPurpleGradient,
      ),
      const FSMenuItem(
        icon: Icon(Icons.add, color: Colors.white),
        text: Text('添加到歐盟', style: TextStyle(color: Colors.white)),
      ),
    ],
  );
}