import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:portfoli_web/providers/user_info.dart'; // Import your provider

void main() {
  UserInfo? provider; // Adjust based on your actual class name and instance creation

  setUp(() {
    provider = UserInfo();
  });

  testWidgets('Test Numeric Input', (WidgetTester tester) async {
    fakeAsync((async) {
      provider!.chatInputController.text = '5';

      async.elapse(const Duration(seconds: 5)); // Advance the timer
      provider!.chatGetReply();

      expect(provider!.rNumber, 5);
    });
  });

  testWidgets('Test Create Container Command', (WidgetTester tester) async {
    fakeAsync((async) {
      provider!.chatInputController.text = 'create container';

      async.elapse(const Duration(seconds: 5)); // Advance the timer
      provider!.chatGetReply();

      expect(provider!.container, isTrue);
      // Add other assertions as needed
    });
  });

  testWidgets('Test Hello Input', (WidgetTester tester) async {
    fakeAsync((async) {
      provider!.chatInputController.text = 'Hello';

      async.elapse(const Duration(seconds: 5)); // If you need to simulate a delay
      provider!.chatGetReply();

      expect(provider!.listMesseges.last.msg, equals('Hello')); // Assuming chatOutput is the variable storing the response
    });
  });


}
