import 'package:cloud_firestore/cloud_firestore.dart';

class UserRecord {
  String id;
  String deviceTypeName;
  String systemName;
  String browserName;
  String address;
  double? deviceMemory;
  double? latitude;
  double? longitude;
  int? screenWidth;
  int? screenHeight;
  String batteryStatus;
  String wifiNetworkStatus;
  bool musicMode;
  bool themeLightMode;
  String themeStringColor;
  String seenChatScreen;
  String seenFullResume;
  String seenAdminScreen;
  String date;

  UserRecord({
    required this.id,
    required this.deviceTypeName,
    required this.systemName,
    required this.browserName,
    required this.address,
    this.deviceMemory,
    this.latitude,
    this.longitude,
    this.screenWidth,
    this.screenHeight,
    required this.batteryStatus,
    required this.wifiNetworkStatus,
    required this.musicMode,
    required this.themeLightMode,
    required this.themeStringColor,
    required this.seenChatScreen,
    required this.seenFullResume,
    required this.seenAdminScreen,
    required this.date,
  });

  factory UserRecord.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserRecord(
      id: snapshot.id,
      deviceTypeName: data['device_type'],
      systemName: data['system_name'],
      browserName: data['browser_name'],
      address: data['address'],
      deviceMemory: data['ram_memory'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      screenWidth: data['screenWidth'],
      screenHeight: data['screenHeight'],
      batteryStatus: data['battery'],
      wifiNetworkStatus: data['wifi'],
      musicMode: data['sound'] == 'true',
      themeLightMode: data['dark_theme'] == 'false',
      themeStringColor: data['color_theme'],
      seenChatScreen: data['seen_chat_screen'],
      seenFullResume: data['seen_full_resume'],
      seenAdminScreen: data['seen_admin_screen'] ?? '0',
      date: data['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'device_type': deviceTypeName,
      'system_name': systemName,
      'browser_name': browserName,
      'address': address,
      'ram_memory': deviceMemory,
      'latitude': latitude,
      'longitude': longitude,
      'screenWidth': screenWidth,
      'screenHeight': screenHeight,
      'battery': batteryStatus,
      'wifi': wifiNetworkStatus,
      'sound': musicMode ? 'true' : 'false',
      'dark_theme': themeLightMode ? 'false' : 'true',
      'color_theme': themeStringColor,
      'seen_chat_screen': seenChatScreen,
      'seen_full_resume': seenFullResume,
      'seen_admin_screen': seenAdminScreen,
      'date': date,
    };
  }
}

class UserRecordRepository {
  static final _collectionRef = FirebaseFirestore.instance.collection('visitors');

  Future<UserRecord?> getRecord(String id) async {
    print('Fetching user record from Firestore with id: $id');
    final documentSnapshot = await _collectionRef.doc(id).get();
    if (documentSnapshot.exists) {
      final userRecord = UserRecord.fromSnapshot(documentSnapshot);
      print('User record found in Firestore: $userRecord');
      return userRecord;
    }
    print('User record not found in Firestore for id: $id');
    return null;
  }

  Future<void> updateRecord(UserRecord record) async {
    print('Updating user record in Firestore with id: ${record.id}');
    final existingRecord = _collectionRef.doc(record.id);
    final data = record.toMap();
    await existingRecord.update(data);
    print('User record updated in Firestore: $record');
  }

  Future<String> addNewRecord(UserRecord record) async {
    print('Adding new user record to Firestore.');
    final newDocumentRef = await _collectionRef.add(record.toMap());
    final newDocumentId = newDocumentRef.id;
    print('New user record added to Firestore with id: $newDocumentId');
    return newDocumentId;
  }

}