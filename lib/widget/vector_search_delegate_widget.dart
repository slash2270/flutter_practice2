import 'package:flutter/material.dart';
import 'package:flutter_practice2/widget/vector_icons_widget.dart';

class VectorSearchDelegateWidget extends SearchDelegate<String?> {
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return VectorIconsWidget(query);
  }

  @override
  Widget buildResults(BuildContext context) {
    return VectorIconsWidget(query);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }
}