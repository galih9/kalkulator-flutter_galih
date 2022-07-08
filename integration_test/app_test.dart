import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:kalkulator/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('perkalian', (WidgetTester tester) async {
    // setup
    app.main();
    await tester.pumpAndSettle();
    final Finder btn9 = find.text('9');
    final Finder btn8 = find.text('8');
    final Finder btnX = find.text('*');
    final Finder btnEqual = find.text('=');

    // do
    await tester.tap(btn9);
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(btnX);
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(btn8);
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(btnEqual);
    await Future.delayed(const Duration(seconds: 1));

    // expect
    expect(find.text('72'), findsOneWidget);
  });
}
