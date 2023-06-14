import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart';
import 'package:aktuel_urunler_bim_a101_sok/pages/market_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/pages/textile_page.dart';
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
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        isRtl: false,
        androidCloseOnBackTap: true,
        mainScreenTapClose: true,
        controller: _drawerController,
        menuScreen: ZoomDrawerMenuScreen(
          setIndex: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
        ),
        mainScreen: currentScreen(),
        menuBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
        borderRadius: 24.0,
        showShadow: true,
        // slideWidth: 200,
        angle: 0.0,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget currentScreen() {
    switch (currentIndex) {
      case Constants.marketPageCode:
        return const MarketPage();
      case Constants.textilePageCode:
        return const TextilePage();

      default:
        return const MarketPage();
    }
  }
}
