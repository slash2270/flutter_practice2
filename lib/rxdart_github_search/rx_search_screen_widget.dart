import 'package:flutter/material.dart';
import 'package:flutter_practice2/rxdart_github_search/rx_search_error_widget.dart';
import 'package:flutter_practice2/rxdart_github_search/rx_search_intro_widget.dart';
import 'package:flutter_practice2/rxdart_github_search/rx_search_loading_widget.dart';
import 'package:flutter_practice2/rxdart_github_search/rx_search_result_widget.dart';

import 'rx_empty_widget.dart';
import 'rx_github_api.dart';
import 'rx_search_bloc.dart';
import 'rx_search_state.dart';

// 基於流的架構中的視圖有兩個參數：狀態流和 onTextChanged 回調。
// 在我們的例子中，onTextChanged 回調將每當調用 Stream<String> 時，將最新的 String 發送到它。
//
// State 將使用 Stream<String> 將新的搜索請求發送到
// GithubAPI。
class RxSearchScreenWidget extends StatefulWidget {
  final RxGithubApi api;

  const RxSearchScreenWidget({Key? key, required this.api}) : super(key: key);

  @override
  RxSearchScreenWidgetState createState() => RxSearchScreenWidgetState();
}

class RxSearchScreenWidgetState extends State<RxSearchScreenWidget> {
  late final RxSearchBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = RxSearchBloc(widget.api);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RxSearchState>(
      stream: bloc.state,
      initialData: RxSearchNoTerm(),
      builder: (BuildContext context, AsyncSnapshot<RxSearchState> snapshot) {
        final state = snapshot.requireData;

        return Scaffold(
          body: Stack(
            children: <Widget>[
              Flex(direction: Axis.vertical, children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '搜尋 Github...',
                    ),
                    style: const TextStyle(
                      fontSize: 36.0,
                      fontFamily: 'Hind',
                      decoration: TextDecoration.none,
                    ),
                    onChanged: bloc.onTextChanged.add,
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildChild(state),
                  ),
                )
              ])
            ],
          ),
        );
      },
    );
  }

  Widget _buildChild(RxSearchState state) {
    if (state is RxSearchNoTerm) {
      return const RxSearchIntroWidget();
    } else if (state is RxSearchEmpty) {
      return const RxEmptyWidget();
    } else if (state is RxSearchLoading) {
      return const RxLoadingWidget();
    } else if (state is RxSearchError) {
      return const RxSearchErrorWidget();
    } else if (state is RxSearchPopulated) {
      return RxSearchResultWidget(items: state.result.items);
    }

    throw Exception('${state.runtimeType} 不支持');
  }
}