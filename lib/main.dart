import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart';
import 'package:aktuel_urunler_bim_a101_sok/firebase_options.dart';
import 'package:aktuel_urunler_bim_a101_sok/providers/is_old_change_notifier.dart';
import 'package:aktuel_urunler_bim_a101_sok/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isOld = prefs.getBool(Constants.isOldKey);
  if (isOld != null) {
    prefs.setBool(Constants.isOldKey, isOld);
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => IsOldNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.routeGenrator,
          title: 'Aktüel Ürünler - Bim A101 Şok',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            primaryColor: const Color(0xFF3B4257),
          ),
        );
      },
    );
  }
}
