// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:portfoli_web/core/push_notifications.dart';
// import 'package:portfoli_web/providers/user_info.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// class MockUserInfo extends Mock implements UserInfo {}
//
// class MockFirebaseApp extends Mock implements FirebaseApp {}
//
// void main() {
//   // This group bundles all tests related to the PushNotificationApp
//   group("PushNotificationApp", () {
//     // Test scenario 1
//     testWidgets("shows CircularProgressIndicator while initializing Firebase",
//         (tester) async {
//       // Mock the initialization of Firebase
//       when(Firebase.initializeApp()).thenAnswer((_) async => MockFirebaseApp());
//
//       // Load the widget in a testable environment
//       await tester.pumpWidget(ChangeNotifierProvider(
//         create: (context) => MockUserInfo(),
//         child: MaterialApp(home: PushNotificationApp()),
//       ));
//
//       // Pump a frame for build
//       await tester.pump();
//
//       // Assert that the CircularProgressIndicator is present on the screen
//       expect(find.byType(CircularProgressIndicator), findsOneWidget);
//     });
//
//     // Test scenario 2
//     testWidgets("shows error if Firebase initialization fails", (tester) async {
//       // Mock the initialization of Firebase to throw an error
//       when(Firebase.initializeApp())
//           .thenThrow(Exception("Firebase Initialization Error"));
//
//       // Load the widget in a testable environment
//       await tester.pumpWidget(ChangeNotifierProvider(
//         create: (context) => MockUserInfo(),
//         child: MaterialApp(home: PushNotificationApp()),
//       ));
//
//       // Pump a frame for build
//       await tester.pump();
//
//       // Assert that the error message is displayed
//       expect(find.text('Firebase Initialization Error'), findsOneWidget);
//     });
//   });
// }
