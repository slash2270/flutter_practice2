import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'inner_drawer_notifier.dart';

class InnerLeftDrawerWidget extends StatefulWidget {
  const InnerLeftDrawerWidget({Key? key}) : super(key: key);

  @override
  State<InnerLeftDrawerWidget> createState() => _InnerLeftDrawerWidgetState();
}

class _InnerLeftDrawerWidgetState extends State<InnerLeftDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    print("build left");

    final double swipeOffset = context.select((InnerDrawerNotifier value) => value.swipeOffset);
    return Material(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  //stops: [0.1, 0.5,0.5, 0.7, 0.9],
                  colors: [
                    ColorTween(
                      begin: Colors.blueAccent,
                      end: Colors.blueGrey[400]!.withRed(100),
                    ).lerp(swipeOffset)!,
                    ColorTween(
                      begin: Colors.green,
                      end: Colors.blueGrey[800]!.withGreen(80),
                    ).lerp(swipeOffset)!,
                  ],
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 10, bottom: 15),
                              width: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  "https://img.icons8.com/officel/2x/user.png",
                                ),
                              ),
                            ),
                            const Text(
                              "使用者",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                          //mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        ListTile(
                          onTap: () => print("Dashboard"),
                          title: const Text(
                            "面板",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          leading: const Icon(
                            Icons.dashboard,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const ListTile(
                          title: Text(
                            "備註名",
                            style: TextStyle(fontSize: 14),
                          ),
                          leading: Icon(
                            Icons.rounded_corner,
                            size: 22,
                          ),
                        ),
                        const ListTile(
                          title: Text(
                            "最愛",
                            style: TextStyle(fontSize: 14),
                          ),
                          leading: Icon(
                            Icons.bookmark_border,
                            size: 22,
                          ),
                        ),
                        const ListTile(
                          title: Text(
                            "關閉好友",
                            style: TextStyle(fontSize: 14),
                          ),
                          leading: Icon(
                            Icons.list,
                            size: 22,
                          ),
                        ),
                        const ListTile(
                          title: Text(
                            "建議的人",
                            style: TextStyle(fontSize: 14),
                          ),
                          leading: Icon(
                            Icons.person_add,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      margin: const EdgeInsets.only(top: 50),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Icon(
                            Icons.all_out,
                            size: 18,
                            color: Colors.grey,
                          ),
                          Text(
                            " 登出",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            swipeOffset < 1
                ? BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: (10 - swipeOffset * 10),
                  sigmaY: (10 - swipeOffset * 10)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0),
                ),
              ),
            )
                : Container(),
          ].where((widget) => widget.toString().isNotEmpty).toList(),
        ));
  }
}