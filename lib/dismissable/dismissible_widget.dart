import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dismissible_story_wrapper.dart';
import 'dissmisible_page_model.dart';

class DismissibleStoryWidget extends StatelessWidget {
  final DismissibleStoryModel story;
  final DismissiblePageModel pageModel;
  const DismissibleStoryWidget({Key? key, required this.story, required this.pageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushTransparentRoute(
          DismissibleStoriesWrapper(
            parentIndex: pageModel.stories.indexOf(story),
            pageModel: pageModel,
          ),
          transitionDuration: pageModel.transitionDuration,
          reverseTransitionDuration: pageModel.reverseTransitionDuration,
        );
      },
      child: DismissibleStoryImage(story),
    );
  }
}

class DismissibleStoryImage extends StatefulWidget {
  final DismissibleStoryModel story;
  final bool isFullScreen;

  DismissibleStoryImage(this.story, {this.isFullScreen = false});

  @override
  _DismissibleStoryImageState createState() => _DismissibleStoryImageState();
}

class _DismissibleStoryImageState extends State<DismissibleStoryImage> {
  late String imageUrl;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.story.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.story.storyId,
      child: Material(
        color: Colors.transparent,
        child: Container(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(widget.isFullScreen ? 20 : 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.isFullScreen ? 0 : 8),
            color: const Color.fromRGBO(237, 241, 248, 1),
            image: DecorationImage(
              onError: (_, __) {
                setState(() {
                  imageUrl = widget.story.altUrl;
                  hasError = true;
                });
              },
              fit: BoxFit.cover,
              image: hasError
                  ? AssetImage(widget.story.altUrl)
                  : NetworkImage(imageUrl) as ImageProvider,
            ),
          ),
          child: Text(
            widget.story.title,
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class DurationSlider extends StatelessWidget {
  final String title;
  final Duration duration;
  final ValueChanged<Duration> onChanged;

  DurationSlider({
    required this.title,
    required this.duration,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$title - ',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${duration.inMilliseconds}ms',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ],
        ),
        Slider(
          value: duration.inMilliseconds.toDouble(),
          min: 0,
          max: 1000,
          divisions: 20,
          label: duration.inMilliseconds.toString(),
          onChanged: (value) {
            onChanged.call(Duration(milliseconds: value.round()));
          },
        ),
      ],
    );
  }
}