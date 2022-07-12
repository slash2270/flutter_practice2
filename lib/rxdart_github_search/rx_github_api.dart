import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class RxGithubApi {
  final String baseUrl;
  final Map<String, RxSearchResult> cache;
  final http.Client client;

  RxGithubApi({
    http.Client? client,
    Map<String, RxSearchResult>? cache,
    this.baseUrl = 'https://api.github.com/search/repositories?q=',
  })  : client = client ?? http.Client(),
        cache = cache ?? <String, RxSearchResult>{};

  /// 使用給定術語在 Github 中搜索存儲庫
  Future<RxSearchResult> search(String term) async {
    final cached = cache[term];
    if (cached != null) {
      return cached;
    } else {
      final result = await _fetchResults(term);

      cache[term] = result;

      return result;
    }
  }

  Future<RxSearchResult> _fetchResults(String term) async {
    final response = await client.get(Uri.parse('$baseUrl$term'));
    final results = json.decode(response.body);

    return RxSearchResult.fromJson(results['items']);
  }
}

class RxSearchResult {
  final List<RxSearchResultItem> items;

  RxSearchResult(this.items);

  factory RxSearchResult.fromJson(dynamic json) {
    final items = (json as List)
        .map((item) => RxSearchResultItem.fromJson(item))
        .toList(growable: false);

    return RxSearchResult(items);
  }

  bool get isPopulated => items.isNotEmpty;

  bool get isEmpty => items.isEmpty;
}

class RxSearchResultItem {
  final String fullName;
  final String url;
  final String avatarUrl;

  RxSearchResultItem(this.fullName, this.url, this.avatarUrl);

  factory RxSearchResultItem.fromJson(Map<String, dynamic> json) {
    return RxSearchResultItem(
      json['full_name'] as String,
      json['html_url'] as String,
      (json['owner'] as Map<String, dynamic>)['avatar_url'] as String,
    );
  }
}