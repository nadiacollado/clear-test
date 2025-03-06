// ignore_for_file: prefer_mixin

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/core/user/domain/user.dart';
import 'package:flutter_starter_kit/features/profile/domain/user_profile_form_state.dart';
import 'package:flutter_starter_kit/features/profile/presentation/edit_user_profile_screen.dart';
import 'package:flutter_starter_kit/features/profile/presentation/user_profile_screen_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/localized_pump.dart';

class MockUserProfileScreenController
    extends AutoDisposeNotifier<UserProfileFormState>
    with Mock
    implements UserProfileScreenController {}

void main() {
  late MockUserProfileScreenController mockController;

  setUp(() {
    mockController = MockUserProfileScreenController();
  });

  Future<Widget> createWidgetUnderTest(WidgetTester tester) async {
    await tester.localizedPump(
      const EditUserProfileScreen(),
      overrides: <Override>[
        userProfileScreenControllerProvider.overrideWith(() => mockController),
      ],
    );

    return tester.firstWidget(find.byType(EditUserProfileScreen));
  }

  testWidgets('Shows loading indicator while fetching user data',
      (WidgetTester tester) async {
    when(() => mockController.getUser())
        .thenAnswer((_) => Stream<User?>.value(null));

    await createWidgetUnderTest(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Calls updateUsername when username field is changed',
      (WidgetTester tester) async {
    const User user = User(email: 'test@example.com', username: 'testUser');

    when(() => mockController.getUser())
        .thenAnswer((_) => Stream<User?>.value(user));
    when(() => mockController.updateUsername(any())).thenReturn(null);

    await createWidgetUnderTest(tester);
    await tester.pump();

    final Finder usernameField = find.byType(TextField);

    expect(usernameField, findsOneWidget);

    await tester.enterText(usernameField, 'newUsername');

    verify(() => mockController.updateUsername('newUsername')).called(1);
  });

  testWidgets('Calls saveProfile and shows success dialog when saving succeeds',
      (WidgetTester tester) async {
    const User user = User(email: 'test@example.com', username: 'testUser');

    when(() => mockController.getUser())
        .thenAnswer((_) => Stream<User?>.value(user));
    when(() => mockController.saveProfile()).thenAnswer((_) async => true);

    await createWidgetUnderTest(tester);
    await tester.pump();

    final Finder saveButton = find.text(tester.t.profile_save);

    expect(saveButton, findsOneWidget);

    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(
      find.textContaining(tester.t.profile_successMessage),
      findsOneWidget,
    );
  });
}
