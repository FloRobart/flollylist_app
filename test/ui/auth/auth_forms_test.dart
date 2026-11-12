import 'package:hollylist_app/ui/auth/code_entry/view_models/code_entry_body_viewmodel.dart';
import 'package:hollylist_app/ui/auth/code_entry/widgets/code_entry_body.dart';
import 'package:hollylist_app/ui/auth/login/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shows a widget of the login screens, in the providers of the application.
Future<void> pumpAuthWidget(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: child)),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUp(
    () =>
        SharedPreferences.setMockInitialValues({'email': 'user@hollylist.fr'}),
  );

  group('Code entry', () {
    testWidgets(
      'Accepts the letters of the codes of Floraccess, in capital letters',
      (tester) async {
        await pumpAuthWidget(tester, const CodeEntryBody());

        await tester.enterText(find.byType(TextFormField), 'ab c12d');
        await tester.pump();

        expect(find.text('ABC12D'), findsOneWidget);
      },
    );

    testWidgets('Shows the email the code was sent to', (tester) async {
      await pumpAuthWidget(tester, const CodeEntryBody());

      expect(find.text('user@hollylist.fr'), findsOneWidget);
    });

    testWidgets(
      'Refuses a code that is too short, without calling the server',
      (tester) async {
        await pumpAuthWidget(tester, const CodeEntryBody());

        await tester.enterText(find.byType(TextFormField), 'ABC');
        await tester.tap(find.text('Vérifier'));
        await tester.pump();

        expect(find.text('Le code contient 6 caractères'), findsOneWidget);
      },
    );

    test('Cleans the code typed by the user', () {
      expect(normalizeLoginCode(' ab c1 2d '), 'ABC12D');
    });
  });

  group('Login form', () {
    testWidgets('Refuses an invalid email, without calling the server', (
      tester,
    ) async {
      await pumpAuthWidget(
        tester,
        const LoginForm(initialEmail: 'not-an-email'),
      );

      await tester.tap(find.text('Se connecter / S\'inscrire'));
      await tester.pump();

      expect(find.text('Adresse email invalide'), findsOneWidget);
    });
  });
}
