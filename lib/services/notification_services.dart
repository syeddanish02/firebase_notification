import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_task_office/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class notifications{


  FirebaseMessaging messaging=FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  void initlocalNotification(BuildContext context, RemoteMessage message)async{
    var androidIntialization= AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosIntialization=DarwinInitializationSettings();
    var intializationsettings=InitializationSettings(
      android: androidIntialization,
      iOS: iosIntialization,
    );
    await flutterLocalNotificationsPlugin.initialize(
      intializationsettings,
      onDidReceiveBackgroundNotificationResponse: (payload){

      }

    );


}
  void firebaseinit(){
    FirebaseMessaging.onMessage.listen((message){
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }

      showNotification(message);

    });

  }
Future<void> showNotification(RemoteMessage message)async{
    AndroidNotificationChannel androidNotificationChannel=AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(),
      'high importance notification',
      importance: Importance.max
    );
    AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
       androidNotificationChannel.id.toString(),
      androidNotificationChannel.name.toString(),
      channelDescription: 'your channel discription',

        importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',

    );
    const DarwinNotificationDetails darwinNotificationDetails=DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notificationDetails=NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    Future.delayed(Duration.zero,(){flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails);

    }



    );

}


  void requestnotificationPermission() async{
    NotificationSettings settings=await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,



    );
    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      print('user grandted permission');

    }else if(settings.authorizationStatus==AuthorizationStatus.provisional){
      print('user grandted provisional  permission');

    }else{
      print('user denied permission');
    }

  }
  Future<String> getDeviceToken()async{
    String? token=await messaging.getToken();
    return token!;
  }
  void TokenRefresh(){
    messaging.onTokenRefresh.listen((event){
      event.toString();
    });
  }
}
