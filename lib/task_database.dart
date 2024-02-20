import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as timezone;
import 'package:todo/task.dart';

class TaskDatabase {
  static FlutterLocalNotificationsPlugin? notification;

  static final Set<Function()> _listeners = {};

  static List<Task> tasks = [];

  static void notifyChange() {
    for (var listener in _listeners) {
      listener();
    }

    const androidNotificationDetails = AndroidNotificationDetails('TodoChannelId', 'TodoChannel',
      channelDescription: 'Channel for todo tasks',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker'
    );

    for (var task in tasks) {
      var notifyTime = task.time.subtract(const Duration(minutes: 10));

      if (task.isCompleted || notifyTime.compareTo(DateTime.now()) <= 0) {
        continue;
      }

      notification?.zonedSchedule(
        "${task.title}${task.time}".hashCode,
        task.title,
        task.note,
        timezone.TZDateTime.from(notifyTime, timezone.local),
        const NotificationDetails(android: androidNotificationDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
      );
    }
  }

  static void addListener(Function() callback) {
    _listeners.add(callback);
  }

  static void removeListener(Function() callback) {
    _listeners.remove(callback);
  }
}