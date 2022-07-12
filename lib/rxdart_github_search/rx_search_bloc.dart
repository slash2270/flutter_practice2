import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'rx_github_api.dart';
import 'rx_search_state.dart';

class RxSearchBloc {
  final Sink<String> onTextChanged;
  final Stream<RxSearchState> state;

  factory RxSearchBloc(RxGithubApi api) {
    final onTextChanged = PublishSubject<String>();

    final state = onTextChanged
    // If the text has not changed, do not perform a new search
        .distinct()
    // Wait for the user to stop typing for 250ms before running a search
        .debounceTime(const Duration(milliseconds: 250))
    // Call the Github api with the given search term and convert it to a
    // State. If another search term is entered, switchMap will ensure
    // the previous search is discarded so we don't deliver stale results
    // to the View.
        .switchMap<RxSearchState>((String term) => _search(term, api))
    // The initial state to deliver to the screen.
        .startWith(RxSearchNoTerm());

    return RxSearchBloc._(onTextChanged, state);
  }

  RxSearchBloc._(this.onTextChanged, this.state);

  void dispose() {
    onTextChanged.close();
  }

  static Stream<RxSearchState> _search(String term, RxGithubApi api) => term.isEmpty
      ? Stream.value(RxSearchNoTerm())
      : Rx.fromCallable(() => api.search(term))
      .map((result) =>
  result.isEmpty ? RxSearchEmpty() : RxSearchPopulated(result))
      .startWith(RxSearchLoading())
      .onErrorReturn(RxSearchError());
}