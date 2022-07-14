import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'inner_env.dart';

class InnerRightDrawerWidget extends StatelessWidget {
  const InnerRightDrawerWidget({required this.innerDrawerKey, Key? key}) : super(key: key);
  final bool _position = true;
  final GlobalKey<InnerDrawerState> innerDrawerKey;

  @override
  Widget build(BuildContext context) {
    print("build right");

    return Material(
        child: SafeArea(
          //top: false,
            right: false,
            left: false,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(width: 1, color: Colors.grey[200]!),
                    right: BorderSide(width: 1, color: Colors.grey[200]!)),
              ),
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Padding(
                          padding:
                          const EdgeInsets.only(top: 12, bottom: 4, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: const <Widget>[
                                  SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: Icon(Icons.person,
                                          color: Colors.white, size: 12),
                                    ),
                                  ),
                                  Text(
                                    "   來賓",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        height: 1.2),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2, right: 25),
                                child: GestureDetector(
                                  child: Icon(
                                    _position
                                        ? Icons.arrow_back
                                        : Icons.arrow_forward,
                                    size: 18,
                                  ),
                                  onTap: () {
                                    innerDrawerKey.currentState?.toggle();
                                  },
                                ),
                              ),
                            ],
                          )),
                      const Divider(),
                      const ListTile(
                        title: Text("統計"),
                        leading: Icon(Icons.show_chart),
                      ),
                      const ListTile(
                        title: Text("活動"),
                        leading: Icon(Icons.access_time),
                      ),
                      const ListTile(
                        title: Text("備註名"),
                        leading: Icon(Icons.rounded_corner),
                      ),
                      const ListTile(
                        title: Text("最愛"),
                        leading: Icon(Icons.bookmark_border),
                      ),
                      const ListTile(
                        title: Text("關閉好友"),
                        leading: Icon(Icons.list),
                      ),
                      const ListTile(
                        title: Text("建議的人"),
                        leading: Icon(Icons.person_add),
                      ),
                      const ListTile(
                        title: Text("打開Facebook"),
                        leading: Icon(
                          Inner_Env.facebook_icon,
                          size: 18,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.only(top: 50),
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                        //width: double.maxFinite,
                        decoration: BoxDecoration(
                          //color: Colors.grey,
                            border: Border(
                                top: BorderSide(
                                  color: Colors.grey[300]!,
                                ))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Icon(
                              Icons.settings,
                              size: 18,
                            ),
                            Text(
                              "  設定",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )));
  }
}