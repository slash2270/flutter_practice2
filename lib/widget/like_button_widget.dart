import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidget extends StatelessWidget {
  LikeButtonWidget({Key? key}) : super(key: key);
  double buttonSize = 30.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LikeButton(
          size: buttonSize,
          circleColor:
          const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
          bubblesColor: const BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.home,
              color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
              size: buttonSize,
            );
          },
          likeCount: 665,
          countBuilder: (int? count, bool isLiked, String text) {
            var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
            Widget result;
            if (count == 0) {
              result = Text(
                "home",
                style: TextStyle(color: color),
              );
            } else {
              result = Text(
                text,
                style: TextStyle(color: color),
              );
            }
            return result;
          },
        ),
        LikeButton(
          size: buttonSize,
          circleColor:
          const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
          bubblesColor: const BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.waving_hand,
              color: isLiked ? Colors.yellow : Colors.grey,
              size: buttonSize,
            );
          },
          likeCount: 665,
          countBuilder: (int? count, bool isLiked, String text) {
            var color = isLiked ? Colors.yellow : Colors.grey;
            Widget result;
            if (count == 0) {
              result = Text(
                "house",
                style: TextStyle(color: color),
              );
            } else {
              result = Text(
                text,
                style: TextStyle(color: color),
              );
            }
            return result;
          },
        ),
        LikeButton(
          size: buttonSize,
          circleColor:
          const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
          bubblesColor: const BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.android,
              color: isLiked ? Colors.green : Colors.grey,
              size: buttonSize,
            );
          },
          likeCount: 665,
          countBuilder: (int? count, bool isLiked, String text) {
            var color = isLiked ? Colors.green : Colors.grey;
            Widget result;
            if (count == 0) {
              result = Text(
                "android",
                style: TextStyle(color: color),
              );
            } else {
              result = Text(
                text,
                style: TextStyle(color: color),
              );
            }
            return result;
          },
        ),
        LikeButton(
          size: buttonSize,
          circleColor:
          const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
          bubblesColor: const BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.apple,
              color: isLiked ? Colors.red : Colors.grey,
              size: buttonSize,
            );
          },
          likeCount: 665,
          countBuilder: (int? count, bool isLiked, String text) {
            var color = isLiked ? Colors.red : Colors.grey;
            Widget result;
            if (count == 0) {
              result = Text(
                "love",
                style: TextStyle(color: color),
              );
            } else {
              result = Text(
                text,
                style: TextStyle(color: color),
              );
            }
            return result;
          },
        ),
      ],
    );
  }
}