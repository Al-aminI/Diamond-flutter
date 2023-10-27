import 'package:diamond/modules/notification_data.dart';
import 'package:flutter/foundation.dart';

class NotificationDataProvider with ChangeNotifier {
  NotificationData? _notificationData;

  NotificationData? get notificationData => _notificationData;

  void setNotificationData(NotificationData data) {
    _notificationData = data;
    notifyListeners();
  }
}
