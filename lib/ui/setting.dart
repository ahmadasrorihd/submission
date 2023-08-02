import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/providers/scheduling_provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  void initState() {
    final dataProvider =
        Provider.of<SchedulingProvider>(context, listen: false);
    dataProvider.getReminderState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SchedulingProvider>(
        builder: (context, scheduled, _) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'Restaurant Notification',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Switch.adaptive(
                    value: scheduled.isScheduled,
                    onChanged: (value) async {
                      scheduled.scheduledNews(value);
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
