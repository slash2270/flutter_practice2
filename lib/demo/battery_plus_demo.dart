import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryPlusDemo extends StatefulWidget {
  const BatteryPlusDemo({Key? key}) : super(key: key);

  @override
  _BatteryPlusDemoState createState() => _BatteryPlusDemoState();
}

class _BatteryPlusDemoState extends State<BatteryPlusDemo> {
  final Battery _battery = Battery();
  BatteryState? _batteryState;
  StreamSubscription<BatteryState>? _batteryStateSubscription;

  @override
  void initState() {
    super.initState();
    _battery.batteryState.then(_updateBatteryState);
    _batteryStateSubscription = _battery.onBatteryStateChanged.listen(_updateBatteryState);
  }

  void _updateBatteryState(BatteryState state) {
    if (_batteryState == state) return;
    setState(() {
      _batteryState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Plus Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_batteryState'),
            ElevatedButton(
              onPressed: () async {
                final batteryLevel = await _battery.batteryLevel;
                // ignore: unawaited_futures
                showDialog<void>(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Text('電池: $batteryLevel%'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('確定'),
                      )
                    ],
                  ),
                );
              },
              child: const Text('獲得電池電量'),
            ),
            ElevatedButton(
                onPressed: () async {
                  final isInPowerSaveMode = await _battery.isInBatterySaveMode;
                  // ignore: unawaited_futures
                  showDialog<void>(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: isInPowerSaveMode ? const Text('處於低功耗模式:是') : const Text('處於低功耗模式:否'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('確定'),
                        )
                      ],
                    ),
                  );
                },
                child: const Text('處於低功耗模式'))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription!.cancel();
    }
  }
}