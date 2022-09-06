import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/left_scroll_actions/left_scroll_list.dart';
import 'package:left_scroll_actions/cupertinoLeftScroll.dart';
import 'package:left_scroll_actions/leftScroll.dart';

import 'left_scroll_row_demo.dart';

class LeftScrollDemo extends StatefulWidget {
  const LeftScrollDemo({Key? key}) : super(key: key);

  @override
  _LeftScrollDemoState createState() => _LeftScrollDemoState();
}

class _LeftScrollDemoState extends State<LeftScrollDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('仿微信左滑'),
        ),
        backgroundColor: const Color(0xFFf5f5f4),
        body: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: MaterialButton(
                color: Colors.blue,
                child: const Text(
                  'ListView 使用演示',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                    builder: (context) => const LeftScrollList(),
                  ));
                },
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(12),
            //   child: MaterialButton(
            //     color: Colors.blue,
            //     child: Text(
            //       'ClosableListView Usage Demo',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //     onPressed: () {
            //       Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) => ClosableListPage(),
            //       ));
            //     },
            //   ),
            // ),
            Container(height: 50),
            Container(
              padding: const EdgeInsets.only(top: 12, left: 8, bottom: 8),
              child: const Text('這些小部件可以滾動到操作。'),
            ),
            LeftScroll(
              buttonWidth: 80,
              buttons: <Widget>[
                LeftScrollItem(
                  text: '刪除',
                  color: Colors.red,
                  onTap: () {
                    LogUtil.e('刪除');
                  },
                ),
                LeftScrollItem(
                  text: '編輯',
                  color: Colors.orange,
                  onTap: () {
                    LogUtil.e('編輯');
                  },
                ),
              ],
              onTap: () {
                LogUtil.e('點擊行');
              },
              child: Container(
                height: 60,
                color: Colors.white,
                alignment: Alignment.center,
                child: const Text('👈 嘗試向左滾動'),
              ),
            ),
            LeftScroll(
              buttons: const <Widget>[
                LeftScrollItem(
                  text: '刪除',
                  color: Colors.red,
                ),
                LeftScrollItem(
                  text: '編輯',
                  color: Colors.orange,
                ),
              ],
              child: Container(
                height: 60,
                color: Colors.white.withOpacity(0.8),
                alignment: Alignment.center,
                child: const Text('如果不透明度不是 1.0，可能會導致問題。'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 12, left: 8, bottom: 8),
              child: const Text('庫比蒂諾左滾動行'),
            ),
            CupertinoLeftScroll(
              buttonWidth: 60,
              buttons: <Widget>[
                LeftScrollItem(
                  text: '刪除',
                  color: Colors.red,
                  onTap: () {
                    LogUtil.e('刪除');
                  },
                ),
                LeftScrollItem(
                  text: '編輯',
                  color: Colors.orange,
                  onTap: () {
                    LogUtil.e('編輯');
                  },
                ),
              ],
              onTap: () {
                LogUtil.e('點擊行');
              },
              child: Container(
                height: 60,
                color: Colors.white,
                alignment: Alignment.center,
                child: const Text('👈 嘗試向左滾動（iOS 風格）'),
              ),
            ),
            CupertinoLeftScroll(
              buttonWidth: 60,
              bounce: true,
              buttons: <Widget>[
                LeftScrollItem(
                  text: '刪除',
                  color: Colors.red,
                  onTap: () {
                    LogUtil.e('刪除');
                  },
                ),
                LeftScrollItem(
                  text: '編輯',
                  color: Colors.orange,
                  onTap: () {
                    LogUtil.e('編輯');
                  },
                ),
              ],
              onTap: () {
                LogUtil.e('點擊行');
              },
              child: Container(
                height: 60,
                color: Colors.white,
                alignment: Alignment.center,
                child: const Text('👈 嘗試向左滾動（帶有反彈的 iOS 樣式）'),
              ),
            ),
            CupertinoLeftScroll(
              opacityChange: true,
              buttonWidth: 80,
              buttons: <Widget>[
                LeftScrollItem(
                  text: '刪除',
                  textColor: Colors.red,
                  color: Colors.red.withOpacity(0),
                  onTap: () {
                    LogUtil.e('刪除');
                  },
                ),
                LeftScrollItem(
                  text: '編輯',
                  textColor: Colors.orange,
                  color: Colors.orange.withOpacity(0),
                  onTap: () {
                    LogUtil.e('編輯');
                  },
                ),
              ],
              onTap: () {
                LogUtil.e('點擊行');
              },
              child: Container(
                height: 60,
                color: Colors.white,
                alignment: Alignment.center,
                child: const Text('👈 嘗試使用 opa 更改的 iOS 樣式'),
              ),
            ),
            Container(height: 50),
            Container(
              padding: const EdgeInsets.only(top: 12, left: 8, bottom: 8),
              child:
              const Text('如果不透明度不是 1.0，您可以像這樣構建小部件。'),
            ),
            LeftScrollRow(
              onDelete: () {
                LogUtil.e('刪除');
              },
              onTap: () {
                LogUtil.e('點擊');
              },
              onEdit: () {
                LogUtil.e('編輯');
              },
            ),
          ],
        ));
  }
}