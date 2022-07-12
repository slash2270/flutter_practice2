import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/material.dart';

import 'extended_at_text.dart';
import 'extended_dollar_text.dart';
import 'extended_emoji_text.dart';

class ExtendedSpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  ExtendedSpecialTextSpanBuilder();

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
        SpecialTextGestureTapCallback? onTap,
        int? index}) {
    if (flag == '') {
      return null;
    }

    // index 是起始標誌的結束索引，所以文本起始索引應該是 index-(flag.length-1)
    if (isStart(flag, ExtendedAtText.flag)) {
      return ExtendedAtText(
        textStyle,
        onTap,
        start: index! - (ExtendedAtText.flag.length - 1),
      );
    } else if (isStart(flag, ExtendedEmojiText.flag)) {
      return ExtendedEmojiText(textStyle, start: index! - (ExtendedEmojiText.flag.length - 1));
    } else if (isStart(flag, ExtendedDollarText.flag)) {
      return ExtendedDollarText(textStyle, onTap,
          start: index! - (ExtendedDollarText.flag.length - 1));
    }
    return null;
  }
}