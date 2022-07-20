import 'package:flutter/widgets.dart';

import 'dissmisible_page_model.dart';

class DismissibleStoryPage extends StatelessWidget {
  final DismissibleStoryModel story;
  final VoidCallback nextGroup;
  final VoidCallback previousGroup;

  const DismissibleStoryPage({Key? key,
    required this.story,
    required this.nextGroup,
    required this.previousGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onTap(TapUpDetails details) async {
      final dx = details.globalPosition.dx;
      final width = MediaQuery.of(context).size.width;
      if (dx < width / 2) return previousGroup();
      return nextGroup();
    }

    return GestureDetector(
      onTapUp: _onTap,
      child: Container()//StoryImage(story, isFullScreen: true),
    );
  }
}