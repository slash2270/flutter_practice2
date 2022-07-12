import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class VibratingDemo extends StatelessWidget {
  const VibratingDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('默認振動 500ms'),
                    onPressed: () {
                      Vibration.vibrate();
                    },
                  ),
                  ElevatedButton(
                    child: const Text('振動 1000ms'),
                    onPressed: () {
                      Vibration.vibrate(duration: 1000);
                    },
                  ),
                  ElevatedButton(
                    child: const Text('模式振動'),
                    onPressed: () {
                      const snackBar = SnackBar(
                        content: Text(
                          '模式：等待0.5s，振動1s，等待0.5s，振動2s，等待0.5s，振動3s，等待0.5s，振動0.5s',
                        ),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                      Vibration.vibrate(
                        pattern: [500, 1000, 500, 2000, 500, 3000, 500, 500],
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text('以模式和幅度振動'),
                    onPressed: () {
                      const snackBar = SnackBar(
                        content: Text(
                          '模式：等待0.5s，振動1s，等待0.5s，振動2s，等待0.5s，振動3s，等待0.5s，振動0.5s',
                        ),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                      Vibration.vibrate(
                        pattern: [500, 1000, 500, 2000, 500, 3000, 500, 500],
                        intensities: [128, 255, 64, 255],
                      );
                    },
                  )
                ],
              ),
            );
          },
    );
  }
}