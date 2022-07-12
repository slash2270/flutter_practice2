import 'package:flutter/material.dart';
import 'package:flutter_practice2/rxdart_github_search/rx_github_api.dart';
import 'package:flutter_practice2/rxdart_github_search/rx_search_screen_widget.dart';

class RxSearchGithubWidget extends StatelessWidget {
  final RxGithubApi api;

  const RxSearchGithubWidget({Key? key, required this.api}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RxSearchScreenWidget(api: api);
  }
}