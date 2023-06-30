import 'package:flutter/material.dart';

class UserDataScreen extends StatelessWidget {
  final String systemName;
  final String browserName;
  final String tokenFcm;
  final String address;
  final String battery;
  final String wifi;
  final String sound;
  final String darkTheme;
  final String colorTheme;
  final String seenChatScreen;
  final String seenFullResume;
  final String date;
  final Function()? onPre;

  const UserDataScreen({
    required this.systemName,
    required this.browserName,
    required this.tokenFcm,
    required this.address,
    required this.battery,
    required this.wifi,
    required this.sound,
    required this.darkTheme,
    required this.colorTheme,
    required this.seenChatScreen,
    required this.seenFullResume,
    required this.date,
    required this.onPre,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: darkTheme.toString() == 'true' ? Colors.black : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildChip(systemName, Icons.phone_android),
            _buildChip(browserName, Icons.web),
            _buildChip(address, Icons.location_on),
            _buildChip(battery, Icons.battery_full),
            _buildChip('', wifi == 'Connected' ? Icons.wifi : Icons.wifi_off),
            _buildChip('', sound.toString() != 'false' ? Icons.volume_up : Icons.volume_off),
            _buildChip('', darkTheme.toString() == 'true' ? Icons.brightness_2 : Icons.sunny),
            _buildChip(date, Icons.calendar_today),
            if (tokenFcm.toString().isNotEmpty && tokenFcm.toString() != 'null')
              ElevatedButton(
                onPressed: onPre,
                child: const Text('Send Message'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, IconData icon) {
    // int _color =
    return Chip(
      label: Text(label),
      avatar: Icon(
        icon,
        color: (colorTheme.toString() != 'null' && colorTheme.toString().isNotEmpty) ? Color(int.parse(colorTheme)): null,
      ),
      backgroundColor: Colors.grey[300],
      labelStyle: TextStyle(
        color: darkTheme.toString() == 'true' ? Colors.white : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }
}