import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class NotificationTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     NotificationService.showNotification(
            //       id: 1,
            //       title: 'Test Notification',
            //       body: 'This is a test notification',
            //       payload: 'test_payload',
            //     );
            //   },
            //   child: Text('Show Immediate Notification'),
            // ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     // Test notification after delay (to test when app is in background)
            //     Future.delayed(Duration(seconds: 5), () {
            //       NotificationService.showNotification(
            //         id: 2,
            //         title: 'Delayed Notification',
            //         body: 'This notification was delayed by 5 seconds',
            //         payload: 'delayed_payload',
            //       );
            //     });
            //   },
            //   child: Text('Show Delayed Notification (5s)'),
            // ),
          ],
        ),
      ),
    );
  }
}