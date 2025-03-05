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
  late MockVoidCallback mockSave;

  setUp(() {
    mockUsernameChanged = MockValueChanged();
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
        ),
      );

      return tester.firstWidget(find.byType(EditUserProfileWidget));
    }

    testWidgets('calls onUsernameChanged when username is changed',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester);

      await tester.enterText(find.byType(CommonTextFormField), 'New Username');

      verify(() => mockUsernameChanged('New Username')).called(1);
    });

    testWidgets('calls onSave when save button is pressed',
        (WidgetTester tester) async {
      await createWidgetUnderTest(tester);

      final Finder saveButtonFinder = find.text(tester.t.profile_save);

      await tester.tap(saveButtonFinder);

      verify(() => mockSave()).called(1);
    });
  });
}
