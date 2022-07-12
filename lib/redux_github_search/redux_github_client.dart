import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'redux_search_result.dart';

class ReduxGithubClient {
  final String baseUrl;
  final Map<String, ReduxSearchResult> cache;
  final HttpClient client;

  ReduxGithubClient({
    HttpClient? client,
    Map<String, ReduxSearchResult>? cache,
    this.baseUrl = 'https://api.github.com/search/repositories?q=',
  })  : client = client ?? HttpClient(),
        cache = cache ?? <String, ReduxSearchResult>{};

  /// Search Github for repositories using the given term
  Future<ReduxSearchResult> search(String term) async {
    if (term.isEmpty) {
      return ReduxSearchResult.noTerm();
    } else if (cache.containsKey(term)) {
      return cache[term]!;
    } else {
      final result = await _fetchResults(term);

      cache[term] = result;

      return result;
    }
  }

  Future<ReduxSearchResult> _fetchResults(String term) async {
    final request = await HttpClient().getUrl(Uri.parse('$baseUrl$term'));
    final response = await request.close();
    final results = json.decode(await response.transform(utf8.decoder).join())
        as Map<String, dynamic>;
    final items = (results['items'] as List).cast<Map<String, dynamic>>();

    return ReduxSearchResult.fromJson(items);
  }
}
