import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiDemo extends StatefulWidget {
  const ConfettiDemo({Key? key}) : super(key: key);

  @override
  _ConfettiDemoState createState() => _ConfettiDemoState();
}

class _ConfettiDemoState extends State<ConfettiDemo> {
  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterRight = ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterLeft = ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 10));
    _controllerBottomCenter = ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  /// 繪製星星的自定義路徑.
  Path drawStar(Size size) {
    // 將度數轉換為弧度的方法
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step), halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep), halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          //中心——爆炸
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality.explosive, // 不指定方向，隨機爆炸
              shouldLoop: true, // 動畫一結束就重新開始
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // 手動指定要使用的顏色
              createParticlePath: drawStar, // 定義自定義形狀/路徑。
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () {
                  _controllerCenter.play();
                },
                child: _display('爆炸星')),
          ),

          //CENTER RIGHT -- Emit left
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: _controllerCenterRight,
              blastDirection: pi, // 徑向值 - LEFT
              particleDrag: 0.05, // 對五彩紙屑應用拖動
              emissionFrequency: 0.05, // 它應該多久發射一次
              numberOfParticles: 20, // 要發射的粒子數
              gravity: 0.05, // 重力 - 或下降速度
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink
              ], // 手動指定要使用的顏色
              strokeWidth: 1,
              strokeColor: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  _controllerCenterRight.play();
                },
                child: _display('左泵')),
          ),

          //CENTER LEFT - 向右發射
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: _controllerCenterLeft,
              blastDirection: 0, // 徑向值 - RIGHT
              emissionFrequency: 0.6,
              minimumSize: const Size(10, 10), // 設置五彩紙屑的最小潛在尺寸（寬度，高度）
              maximumSize: const Size(50, 50), // 設置五彩紙屑的最大潛在尺寸（寬度，高度）
              numberOfParticles: 1,
              gravity: 0.1,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
                onPressed: () {
                  _controllerCenterLeft.play();
                },
                child: _display('單項')),
          ),

          //TOP CENTER - shoot down
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerTopCenter,
              blastDirection: pi / 2,
              maxBlastForce: 5, // 設置較低的最大爆炸力
              minBlastForce: 2, // 設置較低的最小爆炸力
              emissionFrequency: 0.05,
              numberOfParticles: 50, // 一次有很多粒子
              gravity: 1,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: TextButton(
                onPressed: () {
                  _controllerTopCenter.play();
                },
                child: _display('歌利亞')),
          ),
          //BOTTOM CENTER
          Align(
            alignment: Alignment.bottomCenter,
            child: ConfettiWidget(
              confettiController: _controllerBottomCenter,
              blastDirection: -pi / 2,
              emissionFrequency: 0.01,
              numberOfParticles: 20,
              maxBlastForce: 100,
              minBlastForce: 80,
              gravity: 0.3,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
                onPressed: () {
                  _controllerBottomCenter.play();
                },
                child: _display('艱難而罕見')),
          ),
        ],
      ),
    );
  }

  Text _display(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }
}