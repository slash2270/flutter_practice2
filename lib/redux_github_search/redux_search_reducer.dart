import 'package:redux/redux.dart';

import 'redux_search_actions.dart';
import 'redux_search_state.dart';

/// Reducer
final searchReducer = combineReducers<ReduxSearchState>([
  TypedReducer<ReduxSearchState, ReduxSearchEmptyAction>(_onEmpty),
  TypedReducer<ReduxSearchState, ReduxSearchLoadingAction>(_onLoad),
  TypedReducer<ReduxSearchState, ReduxSearchErrorAction>(_onError),
  TypedReducer<ReduxSearchState, ReduxSearchResultAction>(_onResult),
]);

ReduxSearchState _onEmpty(ReduxSearchState state, ReduxSearchEmptyAction action) => ReduxSearchInitial();

ReduxSearchState _onLoad(ReduxSearchState state, ReduxSearchLoadingAction action) => ReduxSearchLoading();

ReduxSearchState _onError(ReduxSearchState state, ReduxSearchErrorAction action) => ReduxSearchError();

ReduxSearchState _onResult(ReduxSearchState state, ReduxSearchResultAction action) =>
    action.result.items.isEmpty
        ? ReduxSearchEmpty()
        : ReduxSearchPopulated(action.result);
