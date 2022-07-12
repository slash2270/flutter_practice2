import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'redux_github_client.dart';
import 'redux_search_middleware.dart';
import 'redux_search_reducer.dart';
import 'redux_search_screen.dart';
import 'redux_search_state.dart';

class ReduxGithubSearchWidget extends StatefulWidget {
  const ReduxGithubSearchWidget({Key? key}) : super(key: key);

  @override
  State<ReduxGithubSearchWidget> createState() => _ReduxGithubSearchWidgetState();
}

class _ReduxGithubSearchWidgetState extends State<ReduxGithubSearchWidget> {

  final store = Store<ReduxSearchState>(
    searchReducer,
    initialState: ReduxSearchInitial(),
    middleware: [
      // 下面的中間件都達到了相同的目的： 加載搜索
      // 來自 github 的響應 SearchActions 的結果。
      //
      // 一個實現為普通中間件，另一個實現為
      // 用於演示目的的史詩。

      ReduxSearchMiddleware(ReduxGithubClient()),
      // EpicMiddleware<SearchState>(SearchEpic(GithubClient())),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<ReduxSearchState>(
      store: store,
      child: const ReduxSearchScreen(),
    );
  }
}
