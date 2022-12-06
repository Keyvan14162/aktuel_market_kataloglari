import 'package:aktuel_urunler_bim_a101_sok/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

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
