import 'package:flutter_test/flutter_test.dart';
import 'package:portfoli_web/main.dart';

void main() {
  // Test the RoleApp widget.
  testWidgets('RoleApp builds without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RoleApp());

    // Verify that the widget was built successfully.
    expect(find.byType(RoleApp), findsOneWidget);
  });
}
