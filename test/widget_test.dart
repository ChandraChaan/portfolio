import 'package:flutter_test/flutter_test.dart';
import 'package:portfoli_web/main.dart';
import 'package:portfoli_web/providers/user_info.dart';
import 'package:provider/provider.dart';

void main() {
  // Test the RoleApp widget.
  testWidgets('RoleApp builds without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider<UserInfo>(
        create: (_) => UserInfo(), // Or your mock data for testing
        child: const RoleApp(),
      ),
    );

    // Verify that the widget was built successfully.
    expect(find.byType(RoleApp), findsOneWidget);
  });
}
