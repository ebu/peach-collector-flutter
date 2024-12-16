part of '../peach_collector.dart';

/// [deviceId] advertising id of device
/// [ops] operation code
/// [appId] Bundle identifier of the mobile application
/// [name] Display name for mobile application,
/// [version] Should follow "Major.Minor.hotfix" format : 1.5.3
/// [device] pe //console, phone, tablet, desktop, hbbtv, tvbox, wearable, embedded
/// [vendor] Apple, Samsung, HTC...
/// [model] iPhone 3.1, Galaxy Nexus...
/// [screenSize] "1680x1050"
/// [language] "en-GB", "fr-FR"...
/// [timezone] hour difference to UTC : -1, 3...
///	[osName] ios, android, macOS...
/// [osVersion] Should follow "Major.Minor.hotfix" format : 1.5.3

class PeachCollectorDataModel {
  final String? deviceId;
  final String? ops;
  final String? appId;
  final String? name;
  final String? version;
  final String? device;
  final String? vendor;
  final String? model;
  final String? screenSize;
  final String? language;
  final String? timezone;
  final String? osName;
  final String? osVersion;
  final String? userSelectedLanguage;
  final bool showLogs;

  PeachCollectorDataModel({
    required this.showLogs,
    required this.deviceId,
    required this.ops,
    required this.appId,
    required this.name,
    required this.version,
    required this.device,
    required this.vendor,
    required this.model,
    required this.screenSize,
    required this.language,
    required this.timezone,
    required this.osName,
    required this.osVersion,
    required this.userSelectedLanguage,
  });

  String peachVersion() {
    return '${1}.${0}.${3}';
  }

  Map<String, dynamic> toJson({
    required String siteKey,
    required Map<String, dynamic> event,
  }) {
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    const implementationVersion = '0.0.1';

    return {
      "peach_schema_version": peachVersion(),
      "peach_implementation_version": implementationVersion,
      "site_key": siteKey,
      "session_start_timestamp": currentTimestamp,
      "sent_timestamp": currentTimestamp,
      "collect_timestamp": 0,
      "language": userSelectedLanguage,
      "client": {
        "id": deviceId,
        "type": "mobileapp",
        "app_id": appId,
        "name": name,
        "version": version,
        "device": {
          "type": device,
          "vendor": vendor,
          "model": model,
          "screen_size": screenSize,
          "language": language,
          "timezone": timezone,
        },
        "os": {
          "name": osName,
          "version": osVersion,
        },
      },
      "events": [event],
    };
  }
}
