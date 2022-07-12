import 'dart:async';

import 'package:flutter/foundation.dart';

class StreamHelper {
  final state = StreamState();

  // 例項化流控制器
  final _controller = StreamController(
    onCancel: () {
      if (kDebugMode) {
        print('StreamHelper cancel');
      }
    },
    onListen: () {
      if (kDebugMode) {
        print('StreamHelper listen');
      }
    },
    onPause: () {
      if (kDebugMode) {
        print('StreamHelper pause');
      }
    },
    onResume: () {
      if (kDebugMode) {
        print('StreamHelper resume');
      }
    },
    sync: false,
  );

  Stream get stream => _controller.stream;
  StreamSink get sink => _controller.sink;

  Stream<dynamic> counter(int second) {
    return Stream.periodic(Duration(seconds: second), (i) {
      state.count = i;
      if(state.count > second){
        sink.close();
        return state.count;
      }
      state.count++;
      sink.add(state.count);
      return state.count;
    });
  }

  void increment() {
    if(state.count > 19){
      sink.close();
      return;
    }
    state.count++;
    sink.add(state.count);
  }

  void decrement() {
    state.count--;
    sink.add(state.count);
    if(state.count < 0){
      sink.close();
      return;
    }
  }

  void dispose() { // 關閉流控制器，釋放資源
    _controller.close();
  }
}

class StreamState {
  int count = 0;
}