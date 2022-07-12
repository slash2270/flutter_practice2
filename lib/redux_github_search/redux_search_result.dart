enum ReduxSearchResultKind { noTerm, empty, populated }

class ReduxSearchResult {
  final ReduxSearchResultKind kind;
  final List<ReduxSearchResultItem> items;

  ReduxSearchResult(this.kind, this.items);

  factory ReduxSearchResult.noTerm() => ReduxSearchResult(ReduxSearchResultKind.noTerm, <ReduxSearchResultItem>[]);

  factory ReduxSearchResult.fromJson(List<Map<String, dynamic>> list) {
    final items = [for (final item in list) ReduxSearchResultItem.fromJson(item)];

    return ReduxSearchResult(
      items.isEmpty ? ReduxSearchResultKind.empty : ReduxSearchResultKind.populated,
      items,
    );
  }

  bool get isPopulated => kind == ReduxSearchResultKind.populated;

  bool get isEmpty => kind == ReduxSearchResultKind.empty;

  bool get isNoTerm => kind == ReduxSearchResultKind.noTerm;
}

class ReduxSearchResultItem {
  final String fullName;
  final String url;
  final String avatarUrl;

  ReduxSearchResultItem(this.fullName, this.url, this.avatarUrl);

  factory ReduxSearchResultItem.fromJson(Map<String, dynamic> json) {
    return ReduxSearchResultItem(
      json['full_name'] as String,
      json['html_url'] as String,
      (json['owner'] as Map<String, dynamic>)['avatar_url'] as String,
    );
  }
}
