// The State represents the data the View requires. The View consumes a Stream
// of States. The view rebuilds every time the Stream emits a State!
//
// The State Stream will emit States depending on the situation: The
// initial state, loading states, the list of results, and any errors that
// happen.
//
// The State Stream responds to input from the View by accepting a
// Stream<String>. We call this Stream the onTextChanged "intent".
import 'redux_search_result.dart';

abstract class ReduxSearchState {}

class ReduxSearchInitial implements ReduxSearchState {}

class ReduxSearchLoading implements ReduxSearchState {}

class ReduxSearchEmpty implements ReduxSearchState {}

class ReduxSearchPopulated implements ReduxSearchState {
  final ReduxSearchResult result;

  ReduxSearchPopulated(this.result);
}

class ReduxSearchError implements ReduxSearchState {}
