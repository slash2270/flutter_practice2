import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class OfflineWidget2 extends StatelessWidget {
  const OfflineWidget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
          ) {
        if (connectivity == ConnectivityResult.none) {
          return Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                '糟糕，\n\n現在我們離線了！',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        } else {
          return child;
        }
      },
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text('沒有按鈕可以按下：)',),
              Text('只需關閉您的互聯網。',),
            ],
          ),
        );
      },
    );
  }
}