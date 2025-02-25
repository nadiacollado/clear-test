import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Future<BuildContext> renderLocalizedWidget(
  WidgetTester tester,
  Widget testedWidget,
) async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: testedWidget,
        navigatorKey: navigatorKey,
      ),
    ),
  );
  return navigatorKey.currentContext!;
}
