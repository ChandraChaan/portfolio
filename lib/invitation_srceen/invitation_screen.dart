import 'package:flutter/material.dart';

class InvitationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Chandra ObulReddy',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Weds',
              style: TextStyle(
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Swetha',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
