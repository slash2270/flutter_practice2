import 'package:flutter/material.dart';
import 'package:flutter_practice2/redux_github_search/redux_search_empty_view.dart';
import 'package:flutter_practice2/redux_github_search/redux_search_error_view.dart';
import 'package:flutter_practice2/redux_github_search/redux_search_initial_view.dart';
import 'package:flutter_practice2/redux_github_search/redux_search_loading_view.dart';
import 'package:flutter_practice2/redux_github_search/redux_search_result_view.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'redux_search_actions.dart';
import 'redux_search_state.dart';

class ReduxSearchScreen extends StatelessWidget {
  const ReduxSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReduxSearchState, _SearchScreenViewModel>(
      converter: (store) {
        return _SearchScreenViewModel(
          state: store.state,
          onTextChanged: (term) => store.dispatch(ReduxSearchAction(term)),
        );
      },
      builder: (BuildContext context, _SearchScreenViewModel vm) {
        return Scaffold(
          body: Flex(direction: Axis.vertical, children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '搜索 Github...',
                ),
                style: const TextStyle(
                  fontSize: 36.0,
                  fontFamily: 'Hind',
                  decoration: TextDecoration.none,
                ),
                onChanged: vm.onTextChanged,
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _buildVisible(vm.state),
              ),
            )
          ]),
        );
      },
    );
  }

  Widget _buildVisible(ReduxSearchState state) {
    if (state is ReduxSearchLoading) {
      return const ReduxSearchLoadingView();
    } else if (state is ReduxSearchEmpty) {
      return const ReduxSearchEmptyView();
    } else if (state is ReduxSearchPopulated) {
      return ReduxSearchPopulatedView(state.result);
    } else if (state is ReduxSearchInitial) {
      return const ReduxSearchInitialView();
    } else if (state is ReduxSearchError) {
      return const ReduxSearchErrorWidget();
    }

    throw ArgumentError('No view for state: $state');
  }
}

class _SearchScreenViewModel {
  final ReduxSearchState state;
  final void Function(String term) onTextChanged;

  _SearchScreenViewModel({required this.state, required this.onTextChanged});
}
