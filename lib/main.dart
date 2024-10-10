import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_task_office/ui/loginscreen.dart';
import 'package:firebase_task_office/ui/splashscreen.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
  );
  FirebaseMessaging.onBackgroundMessage(firebaseOnBackgroundMessages);
  runApp(const MyApp());
}
@pragma('vm:entry-point')
Future<void> firebaseOnBackgroundMessages(RemoteMessage Message) async{
  await Firebase.initializeApp();
  print(Message.notification!.title.toString());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     home: const splashscreen(),
    );
  }
}



