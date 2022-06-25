import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart ' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();
  dynamic locationName;

  Future init({bool initscheduled = false}) async {
    const android = AndroidInitializationSettings("ic_launcher");
    const settings = InitializationSettings(android: android);
    _notification.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotification.add(payload);
      },
    );
    if (initscheduled) {
      tz.initializeTimeZones();
      locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      ),
    );
  }

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required Time scheduledTime,
  }) async {
    return _notification.zonedSchedule(id, title, body,
        _scheduledDaily(scheduledTime), await _notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static tz.TZDateTime _scheduledDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local)
        .add(Duration(hours: time.hour, minutes: time.minute, seconds: 0));
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }
}
