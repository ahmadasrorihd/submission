import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool notification = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Text(
              'Restaurant Notification',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Switch(
                value: notification,
                activeColor: Colors.red,
                onChanged: (bool value) {
                  setState(() {
                    notification = value;
                  });
                })
          ],
        ),
      ),
    );
  }
}
