import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class ComponentPage extends StatelessWidget {
  const ComponentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = [
      _ComponentRow(
        name: '點\n指標',
        item: const DotIndicator(),
      ),
      _ComponentRow(
        name: '輪廓點\n指標',
        item: const OutlinedDotIndicator(),
      ),
      _ComponentRow(
        name: '容器\n指示器',
        item: ContainerIndicator(
          child: Container(
            width: 15.0,
            height: 15.0,
            color: Colors.blue,
          ),
        ),
      ),
      _ComponentRow(
        name: '實線\n連接器',
        item: const SizedBox(
          height: 20.0,
          child: SolidLineConnector(),
        ),
      ),
      _ComponentRow(
        name: '虛線\n連接器',
        item: const SizedBox(
          height: 20.0,
          child: DashedLineConnector(),
        ),
      ),
      _ComponentRow(
        name: '裝飾線\n連接器',
        item: SizedBox(
          height: 20.0,
          child: DecoratedLineConnector(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.lightBlueAccent.shade100],
              ),
            ),
          ),
        ),
      ),
      _ComponentRow(
        name: '簡單時間線節點',
        item: SizedBox(
          height: 50.0,
          child: TimelineNode.simple(),
        ),
      ),
      _ComponentRow(
        name: '複雜時間線節點',
        item: const SizedBox(
          height: 80.0,
          child: TimelineNode(
            indicator: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('複雜'),
              ),
            ),
            startConnector: DashedLineConnector(),
            endConnector: SolidLineConnector(),
          ),
        ),
      ),
      _ComponentRow(
        name: '時間線瓷磚',
        item: TimelineTile(
          oppositeContents: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('相反的\n內容'),
          ),
          contents: Card(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text('內容'),
            ),
          ),
          node: const TimelineNode(
            indicator: DotIndicator(),
            startConnector: SolidLineConnector(),
            endConnector: SolidLineConnector(),
          ),
        ),
      ),
      _ComponentRow(
        name: 'ConnectionDirection.before',
        item: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: FixedTimeline.tileBuilder(
            builder: TimelineTileBuilder.connectedFromStyle(
              connectionDirection: ConnectionDirection.before,
              connectorStyleBuilder: (context, index) {
                return (index == 1)
                    ? ConnectorStyle.dashedLine
                    : ConnectorStyle.solidLine;
              },
              indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
              itemExtent: 40.0,
              itemCount: 3,
            ),
          ),
        ),
      ),
      _ComponentRow(
        name: 'ConnectionDirection.after',
        item: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FixedTimeline.tileBuilder(
            builder: TimelineTileBuilder.connectedFromStyle(
              connectionDirection: ConnectionDirection.after,
              connectorStyleBuilder: (context, index) {
                return (index == 1)
                    ? ConnectorStyle.dashedLine
                    : ConnectorStyle.solidLine;
              },
              indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
              itemExtent: 40.0,
              itemCount: 3,
            ),
          ),
        ),
      ),
      _ComponentRow(
        name: 'ContentsAlign.basic',
        item: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FixedTimeline.tileBuilder(
            builder: TimelineTileBuilder.connectedFromStyle(
              contentsAlign: ContentsAlign.basic,
              oppositeContentsBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('相反的\n內容'),
              ),
              contentsBuilder: (context, index) => const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('內容'),
                ),
              ),
              connectorStyleBuilder: (context, index) =>
              ConnectorStyle.solidLine,
              indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
              itemCount: 3,
            ),
          ),
        ),
      ),
      _ComponentRow(
        name: 'ContentsAlign.reverse',
        item: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FixedTimeline.tileBuilder(
            builder: TimelineTileBuilder.connectedFromStyle(
              contentsAlign: ContentsAlign.reverse,
              oppositeContentsBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('相反的\n內容'),
              ),
              contentsBuilder: (context, index) => const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('內容'),
                ),
              ),
              connectorStyleBuilder: (context, index) =>
              ConnectorStyle.solidLine,
              indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
              itemCount: 3,
            ),
          ),
        ),
      ),
      _ComponentRow(
        name: 'ContentsAlign.alternating',
        item: FixedTimeline.tileBuilder(
          builder: TimelineTileBuilder.connectedFromStyle(
            contentsAlign: ContentsAlign.alternating,
            oppositeContentsBuilder: (context, index) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('相反的\n內容'),
            ),
            contentsBuilder: (context, index) => const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('內容'),
              ),
            ),
            connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
            indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
            itemCount: 3,
          ),
        ),
      ),
      _ComponentRow(
        name: 'Horizontal\nTimeline',
        item: SizedBox(
          height: 150,
          child: Timeline.tileBuilder(
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            builder: TimelineTileBuilder.fromStyle(
              contentsBuilder: (context, index) => const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('內容'),
                ),
              ),
              oppositeContentsBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('相反的\n內容'),
              ),
              itemCount: 20,
            ),
          ),
        ),
      ),
      _ComponentRow(
        name: 'Styled node\nHorizontal\nTimeline',
        item: SizedBox(
          height: 150,
          child: Timeline.tileBuilder(
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            builder: TimelineTileBuilder.fromStyle(
              contentsBuilder: (context, index) => const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('內容'),
                ),
              ),
              oppositeContentsBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('相反的\n內容'),
              ),
              indicatorStyle: IndicatorStyle.outlined,
              connectorStyle: ConnectorStyle.dashedLine,
              itemCount: 20,
            ),
          ),
        ),
      ),
      _ComponentRow(
        name: 'Reverse\nHorizontal\nTimeline',
        item: SizedBox(
          height: 150,
          child: Timeline.tileBuilder(
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            builder: TimelineTileBuilder.fromStyle(
              contentsBuilder: (context, index) => const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('內容'),
                ),
              ),
              oppositeContentsBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('相反的\n內容'),
              ),
              contentsAlign: ContentsAlign.reverse,
              itemCount: 20,
            ),
          ),
        ),
      ),
      _ComponentRow(
        name: 'Alternating\nHorizontal\nTimeline',
        item: SizedBox(
          height: 150,
          child: Timeline.tileBuilder(
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            builder: TimelineTileBuilder.fromStyle(
              contentsBuilder: (context, index) => const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('內容'),
                ),
              ),
              oppositeContentsBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('相反的\n內容'),
              ),
              contentsAlign: ContentsAlign.alternating,
              itemCount: 20,
            ),
          ),
        ),
      ),
      _ComponentRow(
        name: 'Vertical\nTimeline',
        item: SizedBox(
          height: 500,
          child: Timeline.tileBuilder(
            builder: TimelineTileBuilder.fromStyle(
              contentsBuilder: (context, index) => const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('內容'),
                ),
              ),
              oppositeContentsBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('相反的\n內容'),
              ),
              contentsAlign: ContentsAlign.alternating,
              indicatorStyle: IndicatorStyle.outlined,
              connectorStyle: ConnectorStyle.dashedLine,
              itemCount: 10,
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('元件')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          children: children,
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(0.3),
          },
        ),
      ),
    );
  }
}

class _ComponentRow extends TableRow {
  _ComponentRow({
    required String name,
    required Widget item,
  }) : super(
    children: [
      _ComponentName(name),
      _ComponentItem(child: item),
    ],
  );
}

class _ComponentItem extends StatelessWidget {
  const _ComponentItem({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 65.0,
      ),
      child: Center(
        child: child,
      ),
    );
  }
}

class _ComponentName extends StatelessWidget {
  const _ComponentName(
      this.name, {
        Key? key,
      })  : assert(name.length > 0),
        super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return _ComponentItem(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FittedBox(
            child: Text(name),
          ),
        ),
      ),
    );
  }
}