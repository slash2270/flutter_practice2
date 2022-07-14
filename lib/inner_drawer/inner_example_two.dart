import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class InnerExampleTwo extends StatefulWidget {
  const InnerExampleTwo({Key? key}) : super(key: key);

  @override
  _InnerExampleTwoState createState() => _InnerExampleTwoState();
}

class _InnerExampleTwoState extends State<InnerExampleTwo> {
  late AnimationController _animationController;
  late Animation<Color> _bkgColor;
  final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();
  final GlobalKey _keyRed = GlobalKey();
  double _width = 10;
  InnerDrawerAnimation _animationType = InnerDrawerAnimation.static;
  bool _proportionalChildArea = true;
  double _horizontalOffset = 0.4;
  double _verticalOffset = 0.4;
  bool _topBottom = false;
  double _scale = 0.9;
  double _borderRadius = 50;
  final bool _swipe = true;
  final String _title = "Two";

  @override
  void initState() {
    _getWidthContainer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color currentColor = Colors.black54;

  void _getWidthContainer() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final keyContext = _keyRed.currentContext;
      if (keyContext != null) {
        final renderObject = keyContext.findRenderObject()! as RenderBox;
        final size = renderObject.size;
        setState(() {
          _width = size.width;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true,
      offset: IDOffset.only(
          top: _topBottom ? _verticalOffset : 0.0,
          bottom: !_topBottom ? _verticalOffset : 0.0,
          right: _horizontalOffset,
          left: _horizontalOffset),
      scale: IDOffset.horizontal(_scale),
      borderRadius: _borderRadius,
      duration: const Duration(milliseconds: 11200),
      swipe: _swipe,
      proportionalChildArea: _proportionalChildArea,
      //backgroundColor: Colors.red,
      colorTransitionChild: currentColor,
      leftAnimationType: _animationType,
      rightAnimationType: _animationType,
      leftChild: Material(
          color: Theme.of(context).backgroundColor,
          child: const Center(
            child: Text(
              "左邊抽屜",
              style: TextStyle(fontSize: 18),
            ),
          )),
      rightChild: Material(
          color: Theme.of(context).backgroundColor,
          child: const Center(
            child: Text(
              "右邊抽屜",
              style: TextStyle(fontSize: 18),
            ),
          )),
      scaffold: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            //stops: [0.1, 0.5,0.5, 0.7, 0.9],
            colors: [
              Colors.orange,
              Colors.red,
            ],
          ),
        ),
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Row(
                        children: <Widget>[
                          const Text('靜態'),
                          Checkbox(
                              activeColor: Colors.black,
                              value:
                              _animationType == InnerDrawerAnimation.static,
                              onChanged: (a) {
                                setState(() {
                                  _animationType = InnerDrawerAnimation.static;
                                });
                              }),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _animationType = InnerDrawerAnimation.static;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                              activeColor: Colors.black,
                              value:
                              _animationType == InnerDrawerAnimation.linear,
                              onChanged: (a) {
                                setState(() {
                                  _animationType = InnerDrawerAnimation.linear;
                                });
                              }),
                          const Text('線性'),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _animationType = InnerDrawerAnimation.linear;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                              activeColor: Colors.black,
                              value: _animationType ==
                                  InnerDrawerAnimation.quadratic,
                              onChanged: (a) {
                                setState(() {
                                  _animationType =
                                      InnerDrawerAnimation.quadratic;
                                });
                              }),
                          const Text('二次方'),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _animationType = InnerDrawerAnimation.quadratic;
                        });
                      },
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                          activeColor: Colors.black,
                          value: _proportionalChildArea == true,
                          onChanged: (a) {
                            setState(() {
                              _proportionalChildArea = !_proportionalChildArea;
                            });
                          }),
                      const Text('比例兒童區'),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _proportionalChildArea = !_proportionalChildArea;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                Column(
                  children: <Widget>[
                    const Text('水平偏移'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SliderTheme(
                          data: Theme.of(context).sliderTheme.copyWith(
                            valueIndicatorTextStyle: Theme.of(context)
                                .accentTextTheme
                                .bodyText2
                                ?.copyWith(color: Colors.white),
                          ),
                          child: Slider(
                            activeColor: Colors.black,
                            //inactiveColor: Colors.white,
                            value: _horizontalOffset,
                            min: 0.0,
                            max: 1,
                            divisions: 5,
                            semanticFormatterCallback: (double value) =>
                                value.round().toString(),
                            label: '$_horizontalOffset',
                            onChanged: (a) {
                              setState(() {
                                _horizontalOffset = a;
                              });
                            },
                            onChangeEnd: (a) {
                              //_getwidthContainer();
                            },
                          ),
                        ),
                        Text(_horizontalOffset.toString()),
                        //Text(_fontSize.toString()),
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                Column(
                  children: <Widget>[
                    const Text('垂直偏移'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(
                                  activeColor: Colors.black,
                                  value: _topBottom == true,
                                  onChanged: (a) {
                                    setState(() {
                                      _topBottom = true;
                                    });
                                  }),
                              const Text('頂部'),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              _topBottom = true;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(
                                  activeColor: Colors.black,
                                  value: _topBottom == false,
                                  onChanged: (a) {
                                    setState(() {
                                      _topBottom = false;
                                    });
                                  }),
                              const Text('底部'),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              _topBottom = false;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SliderTheme(
                          data: Theme.of(context).sliderTheme.copyWith(
                            valueIndicatorTextStyle: Theme.of(context)
                                .accentTextTheme
                                .bodyText2
                                ?.copyWith(color: Colors.white),
                          ),
                          child: Slider(
                            activeColor: Colors.black,
                            //inactiveColor: Colors.white,
                            value: _verticalOffset,
                            min: 0.0,
                            max: 1,
                            divisions: 5,
                            semanticFormatterCallback: (double value) =>
                                value.round().toString(),
                            label: '$_verticalOffset',
                            onChanged: (a) {
                              setState(() {
                                _verticalOffset = a;
                              });
                            },
                            onChangeEnd: (a) {
                              //_getwidthContainer();
                            },
                          ),
                        ),
                        Text(_verticalOffset.toString()),
                        //Text(_fontSize.toString()),
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                Column(
                  children: <Widget>[
                    const Text('規模'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SliderTheme(
                          data: Theme.of(context).sliderTheme.copyWith(
                            valueIndicatorTextStyle: Theme.of(context)
                                .accentTextTheme
                                .bodyText2
                                ?.copyWith(color: Colors.white),
                          ),
                          child: Slider(
                            activeColor: Colors.black,
                            //inactiveColor: Colors.white,
                            value: _scale,
                            min: 0.0,
                            max: 1,
                            divisions: 10,
                            semanticFormatterCallback: (double value) =>
                                value.round().toString(),
                            label: '$_scale',
                            onChanged: (a) {
                              setState(() {
                                _scale = a;
                              });
                            },
                          ),
                        ),
                        Text(_scale.toString()),
                        //Text(_fontSize.toString()),
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                Column(
                  children: <Widget>[
                    const Text('邊界半徑'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SliderTheme(
                          data: Theme.of(context).sliderTheme.copyWith(
                            valueIndicatorTextStyle: Theme.of(context)
                                .accentTextTheme
                                .bodyText2
                                ?.copyWith(color: Colors.white),
                          ),
                          child: Slider(
                            activeColor: Colors.black,
                            //inactiveColor: Colors.white,
                            value: _borderRadius,
                            min: 0,
                            max: 100,
                            divisions: 4,
                            semanticFormatterCallback: (double value) =>
                                value.round().toString(),
                            label: '$_borderRadius',
                            onChanged: (a) {
                              setState(() {
                                _borderRadius = a;
                              });
                            },
                          ),
                        ),
                        Text(_borderRadius.toString()),
                        //Text(_fontSize.toString()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}