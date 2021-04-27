import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPlugin{
  FlutterLocalNotificationsPlugin localNotification;
  var initializationSettings;

  NotificationPlugin._(){
    init();
  }

  init() async{
    localNotification = FlutterLocalNotificationsPlugin();
    initializePlatformSpecifics();
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
    var scheduleNotificationDateTime = DateTime.now().add(Duration(seconds: timeDifference));
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
    await localNotification.schedule(
      timeDifference,
      'Time to Post!',
      body,
      scheduleNotificationDateTime,
      platformChannelSpecifics,
      payload: 'New Payload',
    );
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