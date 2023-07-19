import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_info.dart';

class UserDataScreen extends StatelessWidget {
  final String systemName;
  final String browserName;
  final String deviceType;
  final String deviceRam;
  final String tokenFcm;
  final String address;
  final String battery;
  final String wifi;
  final String sound;
  final String darkTheme;
  final String colorTheme;
  final String seenChatScreen;
  final String seenFullResume;
  final String seenAdminScreen;
  final String date;
  final Function()? onPre;

  const UserDataScreen({
    required this.systemName,
    required this.browserName,
    required this.deviceRam,
    required this.deviceType,
    required this.tokenFcm,
    required this.address,
    required this.battery,
    required this.wifi,
    required this.sound,
    required this.darkTheme,
    required this.colorTheme,
    required this.seenChatScreen,
    required this.seenFullResume,
    required this.seenAdminScreen,
    required this.date,
    required this.onPre,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: darkTheme.toString() == 'true' ? Colors.black26 : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  if (seenChatScreen != '0') Colors.blue.shade600 else Colors.grey.shade400,
                  if (seenAdminScreen != '0') Colors.deepPurple.shade600 else Colors.grey.shade400,
                  if (seenFullResume != '0') Colors.amber.shade600 else Colors.grey.shade400,
                ],
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildChip(label: systemName, icon: deviceIcon()),
            _buildChip(label: deviceRam, icon: Icons.memory),
            _buildChip(label: browserName, icon: Icons.web),
            _buildChip(label: address, icon: Icons.location_pin),
            _buildChip(label: null, icon: Icons.battery_full),
            _buildChip(
                label: null,
                icon: wifi == 'Connected' ? Icons.wifi : Icons.wifi_off),
            _buildChip(
                label: null,
                icon: sound.toString() != 'false'
                    ? Icons.volume_up
                    : Icons.volume_off),
            _buildChip(
                label: null,
                icon: darkTheme.toString() == 'true'
                    ? Icons.brightness_2
                    : Icons.sunny),
            _buildChip(label: date, icon: Icons.calendar_today),
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

  Widget _buildChip({String? label, required IconData icon}) {
    return Material(
      elevation: 4.0, // Adjust the elevation to control the shadow intensity
      borderRadius: BorderRadius.circular(16.0),
      shadowColor: Colors.grey[400], // Customize the shadow color
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: darkTheme.toString() == 'true' ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: (colorTheme.toString() != 'null' &&
                      colorTheme.toString().isNotEmpty)
                  ? Color(int.parse(colorTheme))
                  : (darkTheme.toString() == 'true'
                      ? Colors.white
                      : Colors.black),
            ),
            if (label != null) ...[
              const SizedBox(width: 8.0),
              Text(
                label ?? '',
                style: TextStyle(
                  color: darkTheme.toString() == 'true'
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData deviceIcon() {
    if (deviceType == 'Mobile') {
      return Icons.phone_android;
    } else if (deviceType == 'Tablet') {
      return Icons.tab;
    } else if (deviceType == 'Desktop') {
      return Icons.desktop_mac;
    } else {
      return Icons.mobile_off;
    }
  }
}
