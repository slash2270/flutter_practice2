import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';

import '../util/function_util.dart';

class OpenSettingDemo extends StatefulWidget {
  const OpenSettingDemo({Key? key}) : super(key: key);

  @override
  _OpenSettingDemoState createState() => _OpenSettingDemoState();
}

class _OpenSettingDemoState extends State<OpenSettingDemo> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openWIFISetting();
              },
              child: Center(
                child: _functionUtil.initText('Wi-fi'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openDataRoamingSetting();
              },
              child: Center(
                child: _functionUtil.initText('Data Roaming'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openLocationSourceSetting();
              },
              child: Center(
                child: _functionUtil.initText('Location Source'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openAppSetting();
              },
              child: Center(
                child: _functionUtil.initText('App Settings'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openBluetoothSetting();
              },
              child: Center(
                child: _functionUtil.initText('Bluetooth'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openNotificationSetting();
              },
              child: Center(
                child: _functionUtil.initText('Notification'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openSecuritySetting();
              },
              child: Center(
                child: _functionUtil.initText('Security'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openSoundSetting();
              },
              child: Center(
                child: _functionUtil.initText('Sound'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openMainSetting();
              },
              child: Center(
                child: _functionUtil.initText('Main Setting'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openDateSetting();
              },
              child: Center(
                child: _functionUtil.initText('Date'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openDisplaySetting();
              },
              child: Center(
                child: _functionUtil.initText('Display'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openAccessibilitySetting();
              },
              child: Center(
                child: _functionUtil.initText('Accessibility'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openAddAccountSetting();
              },
              child: Center(
                child: _functionUtil.initText('Add Account'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openAirplaneModeSetting();
              },
              child: Center(
                child: _functionUtil.initText('Air Plane Mode'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openApnSetting();
              },
              child: Center(
                child: _functionUtil.initText('Apn'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openApplicationDetailsSetting();
              },
              child: Center(
                child: _functionUtil.initText('Application Details'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openApplicationDevelopmentSetting();
              },
              child: Center(
                child: _functionUtil.initText('Application Development'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openHomeSetting();
              },
              child: Center(
                child: _functionUtil.initText('Home'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openAppNotificationBubbleSetting();
              },
              child: Center(
                child: _functionUtil.initText('App Notification Bubble'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openAppNotificationSetting();
              },
              child: Center(
                child: _functionUtil.initText('App Notification'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openSearchSetting();
              },
              child: Center(
                child: _functionUtil.initText('Search'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openBatterySaverSetting();
              },
              child: Center(
                child: _functionUtil.initText('Battery Saver'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openBiometricEnrollSetting();
              },
              child: Center(
                child: _functionUtil.initText('Biometric Enroll'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openCaptioningSetting();
              },
              child: Center(
                child: _functionUtil.initText('Captioning'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openCastSetting();
              },
              child: Center(
                child: _functionUtil.initText('Cast'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openChannelNotificationSetting();
              },
              child: Center(
                child: _functionUtil.initText('Channel Notification'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openActionConditionProviderSetting();
              },
              child: Center(
                child: _functionUtil.initText('Action Condition Provider'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openDataUsageSetting();
              },
              child: Center(
                child: _functionUtil.initText('Data Usage'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openIgnoreBatteryOptimizationSetting();
              },
              child: Center(
                child: _functionUtil.initText('Ignore Battery Optimization'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openDeviceInfoSetting();
              },
              child: Center(
                child: _functionUtil.initText('Device Info'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openDreamSetting();
              },
              child: Center(
                child: _functionUtil.initText('Dream'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openHardKeyboardSetting();
              },
              child: Center(
                child: _functionUtil.initText('Hard Keyboard'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openIgnoreBackgroundDataRestrictionsSetting();
              },
              child: Center(
                child:
                _functionUtil.initText('Ignore Background Data Restrictions'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openInputMethodSetting();
              },
              child: Center(
                child: _functionUtil.initText('Input Method'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openManageAllApplicationsSetting();
              },
              child: Center(
                child: _functionUtil.initText('Manage All Applications'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openInputMethodSubtypeSetting();
              },
              child: Center(
                child: _functionUtil.initText('Input Method Subtype'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openInternalStorageSetting();
              },
              child: Center(
                child: _functionUtil.initText('Internal Storage'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openLocaleSetting();
              },
              child: Center(
                child: _functionUtil.initText('Locale'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openManageAllFilesAccessPermissionSetting();
              },
              child: Center(
                child: _functionUtil.initText('Manage All Files Access Permission'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openManageApplicationSetting();
              },
              child: Center(
                child: _functionUtil.initText('Manage Application'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openManageDefaultAppsSetting();
              },
              child: Center(
                child: _functionUtil.initText('Manage Default Apps'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openNFCSetting();
              },
              child: Center(
                child: _functionUtil.initText('NFC'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openManageAppAllFilesAccessPermissionSetting();
              },
              child: Center(
                child: _functionUtil
                    .initText('Manage App All Files Access Permission'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openManageOverlayPermissionSetting();
              },
              child: Center(
                child: _functionUtil.initText('Manage Overlay Permission'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openManageWriteSetting();
              },
              child: Center(
                child: _functionUtil.initText('Manage Write'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openManageUnknownAppSourceSetting();
              },
              child: Center(
                child: _functionUtil.initText('Manage Unknown App Source'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openMemoryCardSetting();
              },
              child: Center(
                child: _functionUtil.initText('Memory Card'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openNetworkOperatorSetting();
              },
              child: Center(
                child: _functionUtil.initText('Network Operator'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openNotificationAssistantSetting();
              },
              child: Center(
                child: _functionUtil.initText('Notification Assistant'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openNightDisplaySetting();
              },
              child: Center(
                child: _functionUtil.initText('Night Display'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openNotificationListenerDetailSetting();
              },
              child: Center(
                child: _functionUtil.initText('Notification Listener Detail'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openNotificationPolicyAccessSetting();
              },
              child: Center(
                child: _functionUtil.initText('Notification Policy Access'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openActionPrintSetting();
              },
              child: Center(
                child: _functionUtil.initText('Action Print'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openQuickLaunchSetting();
              },
              child: Center(
                child: _functionUtil.initText('Quick Launch'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openActionNotificationListenerSetting();
              },
              child: Center(
                child: _functionUtil.initText('Action Notification Listener'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openPrivacySetting();
              },
              child: Center(
                child: _functionUtil.initText('Privacy'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openProcessWifiEasyConnectUriSetting();
              },
              child: Center(
                child: _functionUtil.initText('Process Wifi Easy Connect Uri'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openQuickAccessWalletSetting();
              },
              child: Center(
                child: _functionUtil.initText('Quick Access Wallet'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openUsageAccessSetting();
              },
              child: Center(
                child: _functionUtil.initText('Usage Access'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openShowRegulatoryInfoSetting();
              },
              child: Center(
                child: _functionUtil.initText('Show Regulatory Info'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openShowWorkPolicyInfoSetting();
              },
              child: Center(
                child: _functionUtil.initText('Show Work Policy Info'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openStorageVolumeAccessSetting();
              },
              child: Center(
                child: _functionUtil.initText('Storage Volume Access'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openZenModePrioritySetting();
              },
              child: Center(
                child: _functionUtil.initText('Zen Mode Priority'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openVoiceControllBatterySaverModeSetting();
              },
              child: Center(
                child: _functionUtil.initText('Voice Controll Battery Saver Mode'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openSyncSetting();
              },
              child: Center(
                child: _functionUtil.initText('Sync'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openUserDictionarySetting();
              },
              child: Center(
                child: _functionUtil.initText('User Dictionary'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openVoiceControllAirplaneModeSetting();
              },
              child: Center(
                child: _functionUtil.initText('Voice Controll Airplane Mode'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openVoiceControllDoNotDisturbModeSetting();
              },
              child: Center(
                child: _functionUtil.initText('Voice Controll Do Not Disturb Mode'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openVoiceInputSetting();
              },
              child: Center(
                child: _functionUtil.initText('Voice Input'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openVrListenerSetting();
              },
              child: Center(
                child: _functionUtil.initText('Vr Listener'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openWebViewSetting();
              },
              child: Center(
                child: _functionUtil.initText('Web View'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openWifiAddNetworksSetting();
              },
              child: Center(
                child: _functionUtil.initText('Wifi Add Networks'),
              ),
            ),
          ],
        ),
        _functionUtil.initSizedBox(15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                OpenSettings.openVPNSetting();
              },
              child: Center(
                child: _functionUtil.initText('VPN'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openWifiIpSetting();
              },
              child: Center(
                child: _functionUtil.initText('Wifi Ip'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                OpenSettings.openWirelessSetting();
              },
              child: Center(
                child: _functionUtil.initText('Wireless'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}