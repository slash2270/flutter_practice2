import 'redux_search_result.dart';

/// Actions
class ReduxSearchAction {
  final String term;

  ReduxSearchAction(this.term);
}

class ReduxSearchEmptyAction {}

class ReduxSearchLoadingAction {}

class ReduxSearchErrorAction {}

class ReduxSearchResultAction {
  final ReduxSearchResult result;

  ReduxSearchResultAction(this.result);
}
