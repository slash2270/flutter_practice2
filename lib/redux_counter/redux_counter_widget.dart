import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
//import 'package:flutter_redux/flutter_redux.dart';
//import 'package:redux/redux.dart';

// 一個簡單的動作：增量
enum Actions { Increment, Decrement }

// 減速器，它獲取先前的計數並在響應中增加它
// 到一個增量動作。
int counterReducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  }
  if (action == Actions.Decrement) {
    return state - 1;
  }
  return state;
}

final store = Store<int>(counterReducer, initialState: 0);

class ReduxCounterWidget extends StatelessWidget {
  const ReduxCounterWidget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The StoreProvider should wrap your MaterialApp or WidgetsApp. This will
    // ensure all routes have access to the store.
    return StoreProvider<int>(
      // Pass the store to the StoreProvider. Any ancestor `StoreConnector`
      // Widgets will find and use this value as the `Store`.
      store: store,
      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 將 Store 連接到呈現當前的 Text Widget
                // 數數。
                //
                // 我們將 Text Widget 包裝在 `StoreConnector` Widget 中。 這
                // `StoreConnector` 將從最近的 `Store` 中找到
                // `StoreProvider` 祖先，將其轉換為
                // 最新計數，並將該字符串傳遞給 `builder` 函數
                // 作為`count`。
                //
                // 每次點擊按鈕時，都會調度一個動作並
                // 運行減速器。 在reducer更新狀態後，
                // Widget 將使用最新的自動重建
                // 數數。 無需手動管理訂閱或流！
                StoreConnector<int, String>(
                  converter: (store) => store.state.toString(),
                  builder: (context, count) {
                    return Text(
                      '這個按鈕已經按了這麼多次了: $count',
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // 將 Store 連接到 FloatingActionButton。 在這種情況下，我們將
                    // 使用 Store 構建一個回調，該回調將分派一個 Increment
                    // 行動。
                    //
                    // 然後，我們將此回調傳遞給按鈕的 `onPressed` 處理程序。
                    StoreConnector<int, VoidCallback>(
                      converter: (store) {
                        // Return a `VoidCallback`, which is a fancy name for a function
                        // with no parameters and no return value.
                        // It only dispatches an Increment action.
                        return () => store.dispatch(Actions.Increment);
                      },
                      builder: (context, callback) {
                        return ElevatedButton(
                          onPressed: callback,
                          child: const Icon(Icons.add),
                        );
                      },
                    ),
                    StoreConnector<int, VoidCallback>(
                      converter: (store) {
                        // Return a `VoidCallback`, which is a fancy name for a function
                        // with no parameters and no return value.
                        // It only dispatches an Increment action.
                        return () => store.dispatch(Actions.Decrement);
                      },
                      builder: (context, callback) {
                        return ElevatedButton(
                          onPressed: callback,
                          child: const Icon(Icons.maximize),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}