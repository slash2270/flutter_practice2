import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'dissmisible_page_model.dart';

class DismissibleScrollablePage extends StatefulWidget {
  final DismissibleStoryModel story;
  const DismissibleScrollablePage(this.story, {Key? key}) : super(key: key);

  @override
  State<DismissibleScrollablePage> createState() => _DismissibleScrollablePageState();
}

class _DismissibleScrollablePageState extends State<DismissibleScrollablePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final child = SizedBox(
      width: size.width,
      height: size.height,
      child: Material(
        color: Colors.transparent,
        child: Hero(
          tag: widget.story.storyId,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Image.network(
              widget.story.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    return DismissiblePage(
      isFullScreen: false,
      direction: DismissiblePageDismissDirection.multi,
      onDismissed: () {
        Navigator.of(context).pop();
      },
      child: child,
    );
  }
}