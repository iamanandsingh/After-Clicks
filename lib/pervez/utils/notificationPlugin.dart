import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationPlugin{
  FlutterLocalNotificationsPlugin localNotification;
  var initializationSettings;

  NotificationPlugin._(){
    init();
  }

  init() async{
    localNotification = FlutterLocalNotificationsPlugin();
    initializePlatformSpecifics();
    tz.initializeTimeZones();
  }

  initializePlatformSpecifics(){
    var androidInitialize = new AndroidInitializationSettings('icon_');
    var iOSInitialize = new IOSInitializationSettings();
    initializationSettings =
    new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await localNotification.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          onNotificationClick(payload);
        });
  }

  Future<void> scheduleNotification(var timeDifference, String body) async{
    var scheduleNotificationDateTime = tz.TZDateTime.now(tz.local).add(Duration(seconds: timeDifference));
    var androidChannelSpecifics = new AndroidNotificationDetails(
      "ID",
      "Name",
      "Description",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    var iosChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    // await localNotification.zonedSchedule(
    //   timeDifference,
    //   'Time to Post!',
    //   body,
    //   scheduleNotificationDateTime,
    //   platformChannelSpecifics,
    //   payload: 'New Payload',
    // );
    await localNotification.zonedSchedule(
        timeDifference,
        'Time to Post!',
        body,
        scheduleNotificationDateTime,
        platformChannelSpecifics,
        // const NotificationDetails(
        //     android: AndroidNotificationDetails(
        //       "ID",
        //       "Name",
        //       "Description",
        //       importance: Importance.max,
        //       priority: Priority.high,
        //       playSound: true,
        //     ),
        //     iOS: IOSNotificationDetails()),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<int> getPendingNotificationCount() async {
    List<PendingNotificationRequest> p =
    await localNotification.pendingNotificationRequests();
    return p.length;
  }

  Future<void> cancelNotification(var id) async {
    await localNotification.cancel(id);
  }

}

NotificationPlugin mNotificationPlugin = NotificationPlugin._();