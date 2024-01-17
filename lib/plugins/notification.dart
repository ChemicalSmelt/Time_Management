import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';


class NotificationPlugin {
  final FlutterLocalNotificationsPlugin np = FlutterLocalNotificationsPlugin();

  init() async {
    tz.initializeTimeZones(); // 初始化時區資料庫
    tz.setLocalLocation(tz.getLocation('Asia/Taipei'));
    // 在 Android 平台上的設置，並使用 flutter logo 作為通知顯示的圖標
    var android = const AndroidInitializationSettings('flutter_logo');

    // 在 iOS 平台上的設置，並設置了 iOS 通知的權限
    var ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    // 註冊不同平台初始化設置的 InitializationSetting 對象
    var initSettings = InitializationSettings(android: android);

    // 使用 np 實例的 initialize 方法初始化本地通知插件
    await np.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {}
    );
  }
  // 觸發通知時，透過呼叫此函式來顯示通知
  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return np.show(id, title, body, await notificationDetails());
  }

  notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max),
      //iOS: DarwinNotificationDetails(),
    );
  }

  Future showScheduledNotification(
      {int id = 0,
        String? title,
        String? body,
        String? payload,
        required DateTime scheduledDate}) async {
    return np.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future showPeriodicNotification(
      {int id = 0,
        String? title,
        String? body,
        String? payload,
        required RepeatInterval interval}) async {
    return np.periodicallyShow(
      id,
      title,
      body,
      interval,
      await notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }


  Future<void> scheduleDayNotification(int id ,String title,
      String body, int hours, int minutes) async {
    await np.zonedSchedule(
        id,
        title,
        body,
        _nextInstanceOfDay(id, hours, minutes),
        await notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
  tz.TZDateTime _nextInstanceOfDay(int id, int hours, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hours, minutes);
    //if (scheduledDate.isBefore(now)) {
      //scheduledDate = scheduledDate.add(const Duration(days: 1));
    //}
    debugPrint("---------OKOKOKOKOK-------");
    debugPrint(now.year.toString());
    debugPrint(now.month.toString());
    debugPrint(now.day.toString());
    debugPrint(hours.toString());
    debugPrint(minutes.toString());
    return scheduledDate;
  }

  Future<void> scheduleWeekly8And20Notification(int id ,String title,
      String body, int day, int hours, int minutes) async {
    await np.zonedSchedule(
        id,
        title,
        body,
        _nextInstanceOf8And20AM(id, day, hours, minutes),
        const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max)),
        androidAllowWhileIdle: true,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
  tz.TZDateTime _nextInstanceOf8And20AM(int id, int day, int hours, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hours, minutes);
    if(scheduledDate.isAfter(tz.TZDateTime(tz.local, now.year, now.month, day, hours, minutes).add(const Duration(days: 1)))){
      removeScheduledNotification(id);
    }
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(hours: 12));
    }
    return scheduledDate;
  }

  check(int id) async{
    final List<PendingNotificationRequest> p = await np.pendingNotificationRequests();
    List<PendingNotificationRequest> p2 = p.where((element) => element.id == id).toList();
    if(p2.isNotEmpty){
      return true;
    }
    return false;
  }

  removeScheduledNotification(int id) async{
    await np.cancel(id);
  }
}