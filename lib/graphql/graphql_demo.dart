/// 調用 Github GraphQL API 的示例函數
///
/// ### 查詢
/// * [readRepositories()]
///
/// ### 突變：
/// * [starRepository(id)]
/// * [removeStarFromRepository(id)]
///
/// 要運行該示例，請創建一個包含以下內容的文件 `lib/local.dart`：
/// ```飛鏢
/// 常量字符串 YOUR_PERSONAL_ACCESS_TOKEN =
/// '<YOUR_PERSONAL_ACCESS_TOKEN>';
/// ```

import 'dart:io' show stdout, stderr, exit;
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:graphql/client.dart';
import '../util/constants.dart';

/// 為 github api 獲取經過身份驗證的 [GraphQLClient]
///
/// `graphql/client.dart` 利用 [gql_link][1] 接口，
/// 重新導出 [HttpLink]、[WebsocketLink]、[ErrorLink] 和 [DedupeLink]，
/// 除了我們自己定義的鏈接（`AuthLink`）
///
/// [1]: https://pub.dev/packages/gql_link

class GraphQLDemo extends StatefulWidget{
  const GraphQLDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GraphQLDemoState();

}

class GraphQLDemoState extends State<GraphQLDemo> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _functionUtil.initElevatedButton1(context, 'read', readRepositories),
          _functionUtil.initElevatedButton1(context, 'star', starRepository),
          _functionUtil.initElevatedButton1(context, 'remove', removeStarFromRepository),
        ],
      ),
    );
  }

  GraphQLClient getGithubGraphQLClient() {
    final Link _link = HttpLink(
      'https://api.github.com/graphql',
      defaultHeaders: {
        'Authorization': 'Bearer ${Constants.githubToken}',
      },
    );

    return GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
  }

  // 查詢示例 - 獲取所有 github 存儲庫
  void readRepositories() async {
    final GraphQLClient _client = getGithubGraphQLClient();

    const int nRepositories = 50;

    final QueryOptions options = QueryOptions(
      document: gql(
        r'''
        query ReadRepositories($nRepositories: Int!) {
          viewer {
            repositories(last: $nRepositories) {
              nodes {
                __typename
                id
                name
                viewerHasStarred
              }
            }
          }
        }
      ''',
      ),
      variables: {
        'nRepositories': nRepositories,
      },
    );

    final QueryResult result = await _client.query(options);

    LogUtil.e('GraphQL read:$result');

    if (result.hasException) {
      stderr.writeln(result.exception.toString());
      exit(2);
    }

    final List<dynamic> repositories = result.data!['viewer']['repositories']['nodes'] as List<dynamic>;

    for (var f in repositories) {
      {stdout.writeln('Id: ${f['id']} Name: ${f['name']}');}
    }

    exit(0);
  }

  // 突變示例 - 將星添加到存儲庫
  void starRepository() async {
    const repositoryID = Constants.githubId;
    if (repositoryID == '') {
      stderr.writeln('存儲庫的 ID 是必需的！');
      exit(2);
    }

    final GraphQLClient _client = getGithubGraphQLClient();

    final MutationOptions options = MutationOptions(
      document: gql(
        r'''
        mutation AddStar($starrableId: ID!) {
          action: addStar(input: {starrableId: $starrableId}) {
            starrable {
              viewerHasStarred
            }
          }
        }
      ''',
      ),
      variables: <String, dynamic>{
        'starrableId': repositoryID,
      },
    );

    final QueryResult result = await _client.mutate(options);

    LogUtil.e('GraphQL star:$result');

    if (result.hasException) {
      stderr.writeln(result.exception.toString());
      exit(2);
    }

    final bool isStarrred = result.data!['action']['starrable']['viewerHasStarred'] as bool;

    if (isStarrred) {
      stdout.writeln('謝謝你的星星！');
    }

    exit(0);
  }

  // 突變示例 - 從存儲庫中刪除星號
  void removeStarFromRepository() async {
    const repositoryID = Constants.githubId;
    if (repositoryID == '') {
      stderr.writeln('存儲庫的 ID 是必需的！');
      exit(2);
    }

    final GraphQLClient _client = getGithubGraphQLClient();

    final MutationOptions options = MutationOptions(
      document: gql(
        r'''
        mutation RemoveStar($starrableId: ID!) {
          action: removeStar(input: {starrableId: $starrableId}) {
            starrable {
              viewerHasStarred
            }
          }
        }
      ''',
      ),
      variables: <String, dynamic>{
        'starrableId': repositoryID,
      },
    );

    final QueryResult result = await _client.mutate(options);

    LogUtil.e('GraphQL remove:$result');

    if (result.hasException) {
      stderr.writeln(result.exception.toString());
      exit(2);
    }

    final bool isStarrred = result.data!['action']['starrable']['viewerHasStarred'] as bool;

    if (!isStarrred) {
      stdout.writeln('對不起，你改變主意了！');
    }

    exit(0);
  }

}