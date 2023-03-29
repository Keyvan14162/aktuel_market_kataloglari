import 'package:aktuel_urunler_bim_a101_sok/pages/banner_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/pages/detail_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/pages/grid_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/pages/market_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/pages/textile_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/pages/zoom_drawer_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/custom_expansion_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? _generateRoute(
      Widget togoPage, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      // we change to material page route
      return CupertinoPageRoute(
          builder: (context) => togoPage, settings: settings);
    } else {
      return CupertinoPageRoute(
          builder: (context) => togoPage, settings: settings);
    }
  }

  static Route<dynamic>? routeGenrator(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return _generateRoute(const ZoomDrawerScreen(), settings);

      case "/customExpansionPanel":
        return _generateRoute(
          CustomExpansionPanel(
            dataFuture: (settings.arguments as List)[0] as Future,
            logoPath: (settings.arguments as List)[1] as String,
            headerText: (settings.arguments as List)[2] as String,
            color: (settings.arguments as List)[3] as Color,
            marketCode: (settings.arguments as List)[4] as int,
          ),
          settings,
        );

      case "/textilePage":
        return _generateRoute(
          const TextilePage(),
          settings,
        );

      case "/marketPage":
        return _generateRoute(
          const MarketPage(),
          settings,
        );

      case "/bannerPage":
        return _generateRoute(
          BannerPage(
            brochurePageUrls: (settings.arguments as List)[0] as List<String>,
            clickedIndex: (settings.arguments as List)[1] as int,
            color: (settings.arguments as List)[2] as Color,
          ),
          settings,
        );

      case "/gridPage":
        return _generateRoute(
          GridPage(
            brochurePageImagesFuture: (settings.arguments as List)[0] as Future,
            date: (settings.arguments as List)[1] as String,
            color: (settings.arguments as List)[2] as Color,
          ),
          settings,
        );

      case "/detailPage":
        return _generateRoute(
          DetailPage(
            imageUrls: (settings.arguments as List)[0] as List<String>,
            clickedIndex: (settings.arguments as List)[1] as int,
          ),
          settings,
        );

      // unknown page
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text("Unknown Route"),
            ),
            body: const Center(
              child: Text("404"),
            ),
          ),
        );
    }
  }
}
