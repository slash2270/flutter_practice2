// @dart = 2.9

import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 這裡是一個自定義條件的例子。
/// 如果對話框打開次數過多，將不會遇到。
/// 使用添加它：`rateMyApp.conditions.add(MaxDialogOpeningCondition(_rateMyApp));`.
class MaxDialogOpeningCondition extends DebuggableCondition {
  /// 最大默認對話框打開計數（包括）。
  final int maxDialogOpeningCount;

  /// 最大星形對話框打開計數（包括）。
  final int maxStarDialogOpeningCount;

  /// 當前對話打開計數。
  int dialogOpeningCount;

  /// 當前星形對話框打開計數。
  int starDialogOpeningCount;

  /// 創建一個新的最大對話打開條件實例。
  MaxDialogOpeningCondition({this.maxDialogOpeningCount = 3, this.maxStarDialogOpeningCount = 3,}) : assert(maxDialogOpeningCount != null), assert(maxStarDialogOpeningCount != null);

  @override
  void readFromPreferences(
      SharedPreferences preferences, String preferencesPrefix) {
    // 在這裡我們可以讀取這些值（或者我們設置它們的默認值）。
    dialogOpeningCount = preferences.getInt('${preferencesPrefix}dialogOpeningCount') ?? 0;
    starDialogOpeningCount = preferences.getInt('${preferencesPrefix}starDialogOpeningCount') ?? 0;
  }

  @override
  Future<void> saveToPreferences(
      SharedPreferences preferences, String preferencesPrefix) async {
    // Here we save our current values.
    await preferences.setInt(
        '${preferencesPrefix}dialogOpeningCount', dialogOpeningCount);
    return preferences.setInt(
        '${preferencesPrefix}starDialogOpeningCount', starDialogOpeningCount);
  }

  @override
  void reset() {
    // Allows to reset this condition values back to their default values.
    dialogOpeningCount = 0;
    starDialogOpeningCount = 0;
  }

  @override
  bool onEventOccurred(RateMyAppEventType eventType) {
    if (eventType == RateMyAppEventType.dialogOpen) {
      // If the default dialog has been opened, we update our default dialog counter.
      dialogOpeningCount++;
      return true; // Returning true allows to trigger a shared preferences save.
    }

    if (eventType == RateMyAppEventType.starDialogOpen) {
      // If the star dialog has been opened, we update our star dialog counter.
      starDialogOpeningCount++;
      return true;
    }

    return false; // 否則，不需要保存任何東西。
  }

  @override
  String get valuesAsString {
    // 允許輕鬆調試此條件。
    return '對話框打開計數 : $dialogOpeningCount\n最大對話框打開計數 : $maxDialogOpeningCount 星形對話框打開計數 : $starDialogOpeningCount\n 最大星形對話框打開計數 : $maxStarDialogOpeningCount';
  }

  @override
  bool get isMet {
    // 這允許檢查在其當前狀態下是否滿足此條件。
    return dialogOpeningCount <= maxDialogOpeningCount && starDialogOpeningCount <= maxStarDialogOpeningCount;
  }
}