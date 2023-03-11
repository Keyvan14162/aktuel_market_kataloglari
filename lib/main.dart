import 'package:aktuel_urunler_bim_a101_sok/firebase_options.dart';
import 'package:aktuel_urunler_bim_a101_sok/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
