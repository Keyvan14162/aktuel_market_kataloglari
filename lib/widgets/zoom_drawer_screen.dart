import 'package:aktuel_urunler_bim_a101_sok/widgets/home_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/zoom_drawer_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ZoomDrawerScreen extends StatefulWidget {
  const ZoomDrawerScreen({super.key});

  @override
  State<ZoomDrawerScreen> createState() => _ZoomDrawerScreenState();
}

class _ZoomDrawerScreenState extends State<ZoomDrawerScreen> {
  final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        isRtl: false,
        androidCloseOnBackTap: true,
        mainScreenTapClose: true,
        controller: _drawerController,
        menuScreen: const ZoomDrawerMenuScreen(),
        mainScreen: const HomePage(),
        menuBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        // openCurve: Curves.easeIn,
        // closeCurve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
