import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<void> initRemoteConfig() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  final String jsonRemoteConfigDefaults = await rootBundle.loadString(
    'assets/remote_config_defaults.json',
  );

  final Map<String, dynamic> remoteConfigDefaults = jsonDecode(
    jsonRemoteConfigDefaults,
  ) as Map<String, dynamic>;

  await remoteConfig.setDefaults(remoteConfigDefaults);

  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ),
  );

  await remoteConfig.fetchAndActivate();
}
