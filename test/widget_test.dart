import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('MyPortfolio mobile smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that owner profile cards are displayed
    expect(find.text('NPM'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Class'), findsOneWidget);

    // Verify that action buttons are present
    expect(find.text('Lihat Experience'), findsOneWidget);
    expect(find.text('Lihat Coursework'), findsOneWidget);
    expect(find.text('Tambah Item'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });
}
