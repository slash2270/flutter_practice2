import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class InnerExampleThree extends StatefulWidget {
  const InnerExampleThree({Key? key}) : super(key: key);

  @override
  _InnerExampleThreeState createState() => _InnerExampleThreeState();
}

class _InnerExampleThreeState extends State<InnerExampleThree> {
  late AnimationController _animationController;
  late Animation<Color> _bkgColor;
  final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();
  final GlobalKey _keyRed = GlobalKey();
  final double _borderRadius = 50;
  final String _title = "Three";
  double _width = 10;

  @override
  void initState() {
    _getWidthContainer();
    myFocusNode = FocusNode();
    myFocusNode2 = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    myFocusNode2.dispose();
    super.dispose();
  }

  Color currentColor = Colors.black54;

  void _getWidthContainer() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final keyContext = _keyRed.currentContext;
      if (keyContext != null) {
        final RenderBox box = keyContext.findRenderObject() as RenderBox;
        final size = box.size;
        setState(() {
          _width = size.width;
        });
      }
    });
  }

  late FocusNode myFocusNode;
  late FocusNode myFocusNode2;

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true,
      //tapScaffoldEnabled: true,
      borderRadius: _borderRadius,
      swipeChild: true,
      leftAnimationType: InnerDrawerAnimation.quadratic,
      leftChild: Material(
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "左邊抽屜",
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  focusNode: myFocusNode2,
                ),
                /*ListView.builder(
              itemCount: 5,
              itemBuilder:(BuildContext context, int index){
                return ListTile(title: Text('test $index'),);
              },
            )*/
              ],
            ),
          )),
      scaffold: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            //stops: [0.1, 0.5,0.5, 0.7, 0.9],
            colors: [
              Colors.green[200]!,
              Colors.green[500]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
                height: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    TextField(
                      focusNode: myFocusNode,
                    ),
                    const TextField(
                      //  focusNode: myFocusNode,
                    ),
                  ],
                )),
          ),
        ),
      ),
      innerDrawerCallback: (a) {
        print(a);
        if (a) {
          myFocusNode2.requestFocus();
        } else {
          myFocusNode.requestFocus();
        }
      },
    );
  }
}