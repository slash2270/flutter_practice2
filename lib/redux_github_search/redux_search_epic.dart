import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import 'redux_github_client.dart';
import 'redux_search_actions.dart';
import 'redux_search_state.dart';

/// 搜索史詩提供與搜索中間件相同的功能，
/// 但使用 redux_epics 和 RxDart 包來執行工作。 它會
/// 監聽搜索動作並在用戶停止輸入後執行搜索
/// 250 毫秒。
///
/// 如果之前的搜索仍在加載，我們將取消操作並
/// 獲取一組結果。 這確保只有最新搜索的結果
/// 顯示術語。
class ReduxSearchEpic implements EpicClass<ReduxSearchState> {
  final ReduxGithubClient api;

  ReduxSearchEpic(this.api);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<ReduxSearchState> store) {
    return actions
        // Narrow down to SearchAction actions
        .whereType<ReduxSearchAction>()
        // Don't start searching until the user pauses for 250ms
        .debounce((_) => TimerStream<void>(true, const Duration(milliseconds: 250)))
        // Cancel the previous search and start a one with switchMap
        .switchMap<dynamic>((action) => _search(action.term));
  }

  // Use the async* function to make our lives easier
  Stream<dynamic> _search(String term) async* {
    if (term.isEmpty) {
      yield ReduxSearchEmptyAction();
    } else {
      // Dispatch a SearchLoadingAction to show a loading spinner
      yield ReduxSearchLoadingAction();

      try {
        // If the api call is successful, dispatch the results for display
        yield ReduxSearchResultAction(await api.search(term));
      } catch (e) {
        // If the search call fails, dispatch an error so we can show it
        yield ReduxSearchErrorAction();
      }
    }
  }
}
