// this will be used as notification channel id
import 'dart:async';
import 'dart:ui';

import 'package:data_enhencer/logger.dart';
import 'package:data_enhencer/services/internet_speed_service.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const notificationChannelId = 'my_foreground';

// this will be used for notification id, So you can update your custom notification with this id.
const notificationId = 888;

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId, // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high, // importance must be at low or higher level
  );


  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
      androidConfiguration: AndroidConfiguration(
        // Android specific configuration
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: notificationChannelId,
        initialNotificationTitle: 'AWESOME SERVICE',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: notificationId,
      ),
      iosConfiguration: IosConfiguration());
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async{
  customLogger.info('service started from the foreground service');
  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

 //define your custom logic here on prediodic task
  Timer.periodic(const Duration(seconds: 10), (timer) async{
    if (service is AndroidServiceInstance){
      if (await service.isForegroundService()){
        flutterLocalNotificationsPlugin.show(
          notificationId,
          'COOL SERVICE TO FIX YOUR DATA',
          'Data Enhancer ${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              notificationChannelId,
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
        service.setForegroundNotificationInfo(title: "Data enhancer", content: "this is a foreground service");
      } 
    }

    customLogger.info( ' starting the check Process of the app  ');
    var data   =  await finalCheck();
    if (data){
      customLogger.error("Data is on and internet is working");
    }else{
      customLogger.info("Mobile data is not working or Mobile Data is off  ");
    }


    
   });

}
