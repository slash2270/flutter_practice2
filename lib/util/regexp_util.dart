class RegExpUtil {

// 邮箱判断
static bool isEmail(String input) {
String regexEmail = r"^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
if (input == null || input.isEmpty) return false;
return RegExp(regexEmail).hasMatch(input);
}

// 纯数字
static const String DIGIT_REGEX1 = "[0-9]";

// 數字.
static const String DIGIT_REGEX2 = r".[0-9]+";

// 含有数字
static const String CONTAIN_DIGIT_REGEX = r".*[0-9].*";

// 纯字母
static const String LETTER_REGEX = r"[a-zA-Z]+";

// 包含字母
static const String SMALL_CONTAIN_LETTER_REGEX = r".*[a-z].*";

// 包含字母
static const String BIG_CONTAIN_LETTER_REGEX = r".*[A-Z].*";

// 包含字母
static const String CONTAIN_LETTER_REGEX = r".*[a-zA-Z].*";

// 纯中文
static const String CHINESE_REGEX1 = r"[\u4e00-\u9fa5]";

// 纯中文,
static const String CHINESE_REGEX2 = r"[\u4e00-\u9fa5],";

// 仅仅包含字母和数字
static const String LETTER_DIGIT_REGEX = r"^[a-z0-9A-Z]+\$";
static const String CHINESE_LETTER_REGEX = r"([\u4e00-\u9fa5]+|[a-zA-Z]+)";
static const String CHINESE_LETTER_DIGIT_REGEX = r"^[a-z0-9A-Z\u4e00-\u9fa5]+\$";

// 纯数字
static bool isNumber1(String input) {
if (input == null || input.isEmpty) return false;
return RegExp(DIGIT_REGEX1).hasMatch(input);
}

// 纯数字
  static bool isNumber2(String input) {
    if (input == null || input.isEmpty) return false;
    return RegExp(DIGIT_REGEX2).hasMatch(input);
  }

// 含有数字
static bool hasDigit(String input) {
if (input == null || input.isEmpty) return false;
return RegExp(CONTAIN_DIGIT_REGEX).hasMatch(input);
}

// 是否包含中文
static bool isChinese1(String input) {
if (input == null || input.isEmpty) return false;
return RegExp(CHINESE_REGEX1).hasMatch(input);
}

// 是否包含中文
  static bool isChinese2(String input) {
    if (input == null || input.isEmpty) return false;
    return RegExp(CHINESE_REGEX2).hasMatch(input);
  }
}