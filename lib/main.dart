import 'package:aktuel_urunler_bim_a101_sok/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// firebase massaging
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// background works on when app terminatet to i guess

// Background, when app is on background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  // firebase massaging
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // background handling
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  // Foreground, when using app
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.routeGenrator,
      title: 'Aktüel Ürünler - Bim A101 Şok',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: const Color(0xFF3B4257),
      ),
    );
  }
}
