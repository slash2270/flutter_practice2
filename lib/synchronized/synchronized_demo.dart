import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';
import '../util/function_util.dart';

Future<void> writeSlow(int value) async {
  await Future.delayed(const Duration(milliseconds: 1));
  stdout.write(value);
}

Future<void> write(List<int> values) async {
  for (var value in values) {
    await writeSlow(value);
  }
}

Future<void> write1234() async {
  await write([1, 2, 3, 4]);
}

class SynchronizedDemo extends StatelessWidget{
  const SynchronizedDemo({Key? key}) : super(key: key);

  Future<void> test1() async {
    stdout.writeln('非同步');
    //await Future.wait([write1234(), write1234()]);
    // ignore: unawaited_futures
    write1234();
    // ignore: unawaited_futures
    write1234();

    await Future.delayed(const Duration(milliseconds: 50));
    stdout.writeln();
  }

  Future<void> test2() async {
    stdout.writeln('同步');

    var lock = Lock();
    // ignore: unawaited_futures
    lock.synchronized(write1234);
    // ignore: unawaited_futures
    lock.synchronized(write1234);

    await Future.delayed(const Duration(milliseconds: 50));

    stdout.writeln();
  }

  Future<void> readme1() async {
    var lock = Lock();

    // ...
    await lock.synchronized(() async {
      // do some stuff
    });
  }

  Future<void> readme2() async {
    var lock = Lock();
    if (!lock.locked) {
      await lock.synchronized(() async {
        // do some stuff
      });
    }
  }

  Future<void> readme3() async {
    var lock = Lock();
    var value = await lock.synchronized(() {
      return 1;
    });
    stdout.writeln('得到了價值: $value');
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return FunctionUtil().initText2('請查看Log', Colors.black, Colors.transparent, 24);
  }

  _init() async{
    await test1();
    await test2();
    await readme1();
    await readme2();
    await readme3();
  }

}
