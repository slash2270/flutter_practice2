import 'package:flutter/material.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

class SwitcherDemo extends StatefulWidget {
  const SwitcherDemo({Key? key}) : super(key: key);

  @override
  _SwitcherDemoState createState() => _SwitcherDemoState();
}

class _SwitcherDemoState extends State<SwitcherDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Switcher Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '小',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50),
                    Switcher(
                      value: false,
                      colorOff: Colors.purple.withOpacity(0.3),
                      colorOn: Colors.purple,
                      onChanged: (bool state) {
                        //
                      },
                      size: SwitcherSize.small,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '中',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    Switcher(
                      value: false,
                      colorOff: Colors.orange.withOpacity(0.3),
                      colorOn: Colors.orange,
                      size: SwitcherSize.medium,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '大',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    Switcher(
                      value: false,
                      size: SwitcherSize.large,
                      colorOff: Colors.green.withOpacity(0.3),
                      colorOn: Colors.green,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '小',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50),
                    Switcher(
                      value: false,
                      size: SwitcherSize.small,
                      colorOff: Colors.amber.withOpacity(0.3),
                      colorOn: Colors.amber,
                      switcherButtonBoxShape: BoxShape.rectangle,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '中',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    Switcher(
                      value: false,
                      size: SwitcherSize.medium,
                      colorOff: Colors.blueGrey.withOpacity(0.3),
                      colorOn: Colors.blueGrey,
                      switcherButtonBoxShape: BoxShape.rectangle,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '大',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    Switcher(
                      value: false,
                      iconOff: const IconData(0),
                      size: SwitcherSize.large,
                      colorOff: Colors.indigo.withOpacity(0.3),
                      colorOn: Colors.indigo,
                      switcherButtonBoxShape: BoxShape.rectangle,
                      enabledSwitcherButtonRotate: false,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '小',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50),
                    Switcher(
                      value: false,
                      size: SwitcherSize.small,
                      switcherButtonRadius: 50,
                      switcherButtonAngleTransform: 0,
                      switcherRadius: 0,
                      colorOff: Colors.pink.withOpacity(0.3),
                      colorOn: Colors.pink,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '中',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    Switcher(
                      value: false,
                      size: SwitcherSize.medium,
                      switcherButtonRadius: 3,
                      switcherRadius: 0,
                      colorOff: Colors.cyan.withOpacity(0.3),
                      colorOn: Colors.cyan,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '大',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    Switcher(
                      value: false,
                      size: SwitcherSize.large,
                      switcherButtonRadius: 3,
                      iconOff: const IconData(0),
                      colorOff: Colors.brown.withOpacity(0.3),
                      colorOn: Colors.brown,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '小',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50),
                    Switcher(
                      value: false,
                      size: SwitcherSize.small,
                      switcherButtonRadius: 50,
                      switcherButtonAngleTransform: 0,
                      switcherRadius: 0,
                      enabledSwitcherButtonRotate: false,
                      colorOff: Colors.red.withOpacity(0.3),
                      colorOn: Colors.red,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '中',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    Switcher(
                      value: false,
                      size: SwitcherSize.medium,
                      switcherButtonRadius: 3,
                      switcherRadius: 0,
                      enabledSwitcherButtonRotate: false,
                      colorOff: Colors.teal.withOpacity(0.3),
                      colorOn: Colors.teal,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '大',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    Switcher(
                      value: false,
                      size: SwitcherSize.large,
                      switcherButtonRadius: 50,
                      iconOff: const IconData(0),
                      enabledSwitcherButtonRotate: false,
                      colorOff: Colors.blueGrey.withOpacity(0.3),
                      colorOn: Colors.blue,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '小',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50),
                    Switcher(
                      value: false,
                      size: SwitcherSize.small,
                      switcherButtonRadius: 50,
                      switcherButtonAngleTransform: 0,
                      switcherRadius: 0,
                      iconOff: Icons.airplanemode_off_sharp,
                      iconOn: Icons.airplanemode_on_sharp,
                      colorOff: Colors.blueGrey.withOpacity(0.3),
                      colorOn: Colors.purple,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '中',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    Switcher(
                      value: false,
                      size: SwitcherSize.medium,
                      switcherButtonRadius: 3,
                      switcherRadius: 0,
                      iconOff: Icons.thumb_down_rounded,
                      iconOn: Icons.thumb_up_rounded,
                      colorOff: Colors.blueGrey.withOpacity(0.3),
                      colorOn: Colors.teal,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '大',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    Switcher(
                      value: false,
                      size: SwitcherSize.large,
                      switcherButtonRadius: 50,
                      enabledSwitcherButtonRotate: true,
                      iconOff: Icons.lock,
                      iconOn: Icons.lock_open,
                      colorOff: Colors.blueGrey.withOpacity(0.3),
                      colorOn: Colors.blue,
                      onChanged: (bool state) {
                        //
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}