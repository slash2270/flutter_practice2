import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopeModelWidget extends StatelessWidget {
  const ScopeModelWidget({Key? key, required this.model}) : super(key: key);

  final CounterModel model;

  @override
  Widget build(BuildContext context) {
    // 在我們的應用程序的頂層，我們將創建一個 ScopedModel Widget。 這個
    // 將 CounterModel 提供給應用程序中請求它的所有子項
    // 使用 ScopedModelDescendant。
    return ScopedModel<CounterModel>(
      model: model,
      child: const CounterHome(),
    );
  }
}

// 首先創建一個具有計數器和遞增方法的類。
//
// 注意：它必須從模型擴展。
class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    // 首先，遞增計數器
    _counter++;
    // 然後通知所有的監聽器。
    notifyListeners();
  }

  void decrement(){
    _counter--;
    notifyListeners();
  }

}

class CounterHome extends StatelessWidget {

  const CounterHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('您已經多次按下按鈕：'),
        // 創建一個 ScopedModelDescendant。這個小部件將獲得
        // CounterModel 來自最近的父 ScopedModel<CounterModel>。
        // 它將把 CounterModel 交給我們的 builder 方法，並且
        // 每當 CounterModel 改變時重建（即在我們
        // `notifyListeners` 在模型中）。
        ScopedModelDescendant<CounterModel>(
          builder: (context, child, model) {
            return Text(
              model.counter.toString(),
              style: Theme.of(context).textTheme.headline4,
            );
          },
        ),
        // 再次使用 ScopedModelDescendant 以使用增量
        // 來自 CounterModel 的方法
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            ScopedModelDescendant<CounterModel>(
              builder: (context, child, model) {
                return ElevatedButton(
                  onPressed: model.increment,
                  child: const Icon(Icons.arrow_upward),
                );
              },
            ),
            ScopedModelDescendant<CounterModel>(
              builder: (context, child, model) {
                return ElevatedButton(
                  onPressed: model.decrement,
                  child: const Icon(Icons.arrow_downward),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}