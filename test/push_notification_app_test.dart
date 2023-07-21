import 'package:flutter_test/flutter_test.dart';
import 'package:portfoli_web/chat_game/chat_mini_game.dart';
import 'package:portfoli_web/core/push_notifications.dart';

void main() {
  // Test the PushNotificationApp widget.
  testWidgets('PushNotificationApp builds without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PushNotificationApp());

    // Verify that the widget was built successfully.
    expect(find.byType(PushNotificationApp), findsOneWidget);

    // Wait for the initialization to complete by pumping frames.
    await tester.pumpAndSettle();

    // Verify that the ChatGame widget is displayed after initialization.
    expect(find.byType(ChatGame), findsOneWidget);
  });
}
