import 'package:flutter_test/flutter_test.dart';
import 'package:wo_app/main.dart';

void main() {
  testWidgets('WO app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
