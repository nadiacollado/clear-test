import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/common_widgets/common_text_form_field.dart';
import 'package:flutter_starter_kit/features/profile/presentation/edit_user_profile_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/localized_pump.dart';

class MockValueChanged extends Mock {
  void call(String value);
}

class MockVoidCallback extends Mock {
  void call();
}

void main() {
  late MockValueChanged mockUsernameChanged;
  late MockValueChanged mockFirstNameChanged;
  late MockValueChanged mockLastNameChanged;
  late MockValueChanged mockPronounsChanged;
  late MockValueChanged mockAgeChanged;
  late MockValueChanged mockLocationChanged;
  late MockValueChanged mockBioChanged;
  late MockVoidCallback mockSave;

  setUp(() {
    mockUsernameChanged = MockValueChanged();
    mockFirstNameChanged = MockValueChanged();
    mockLastNameChanged = MockValueChanged();
    mockPronounsChanged = MockValueChanged();
    mockAgeChanged = MockValueChanged();
    mockLocationChanged = MockValueChanged();
    mockBioChanged = MockValueChanged();
    mockSave = MockVoidCallback();
  });

  group('EditUserProfileWidget', () {
    const String testUser = 'testuser@example.com';
    const String testUsername = 'Test User';
    Future<Widget> createWidgetUnderTest(WidgetTester tester) async {
      await tester.localizedPump(
        EditUserProfileWidget(
          username: testUsername,
          email: testUser,
          onUsernameChanged: mockUsernameChanged.call,
          onSave: mockSave.call,
          onFirstNameChanged: mockFirstNameChanged.call,
          onLastNameChanged: mockLastNameChanged.call,
          onPronounsChanged: mockPronounsChanged.call,
          onAgeChanged: mockAgeChanged.call,
          onLocationChanged: mockLocationChanged.call,
          onBioChanged: mockBioChanged.call,
        ),
      );

      return tester.firstWidget(find.byType(EditUserProfileWidget));
    }

    testWidgets('calls onUsernameChanged when username is changed',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester);

      final Finder usernameField = find.byWidgetPredicate(
        (Widget widget) =>
            widget is TextField &&
            widget.decoration?.hintText == tester.t.profile_username,
      );

      await tester.enterText(usernameField, 'New Username');

      verify(() => mockUsernameChanged('New Username')).called(1);
    });

    testWidgets('calls onSave when save button is pressed',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester);

      final Finder saveButton = find.text(tester.t.profile_save);

      await tester.ensureVisible(saveButton);
      await tester.tap(saveButton);

      verify(() => mockSave()).called(1);
    });
  });
}
