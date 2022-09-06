import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class OfflineWidget3 extends StatelessWidget {
  const OfflineWidget3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      debounceDuration: Duration.zero,
      connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
          ) {
        if (connectivity == ConnectivityResult.none) {
          return Container(
            color: Colors.white70,
            child: const Center(
              child: Text(
                '糟糕，\n\n我們遇到了延遲離線！',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        }
        return child;
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              '沒有要按下的按鈕 :)',
            ),
            Text(
              '只要關掉你的互聯網。',
            ),
            Text(
              '這個有點延遲。',
            ),
          ],
        ),
      ),
    );
  }
}