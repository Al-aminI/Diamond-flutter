import 'package:diamond/pages/websocket_service.dart';
import 'package:flutter/material.dart';

class PushNotificationScreen extends StatefulWidget {
  final WebSocketService webSocketService;

  const PushNotificationScreen({super.key, required this.webSocketService});

  @override
  State createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  @override
  void initState() {
    super.initState();
    widget.webSocketService.notifications.listen((message) {
      // Handle incoming WebSocket message and trigger push notification
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Push Notifications')),
      body: const Center(
        child: Text('Content goes here'),
      ),
    );
  }
}
