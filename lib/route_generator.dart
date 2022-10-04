import 'package:aktuel_urunler_bim_a101_sok/a101_banner_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/a101_grid_view.dart';
import 'package:aktuel_urunler_bim_a101_sok/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? _generateRoute(
      Widget togoPage, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialPageRoute(
          builder: (context) => togoPage, settings: settings);
    } else {
      return CupertinoPageRoute(
          builder: (context) => togoPage, settings: settings);
    }
  }

  static Route<dynamic>? routeGenrator(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return _generateRoute(HomePage(), settings);

      case "/a101BannerPage":
        return _generateRoute(
          A101BannerPage(
            categoryUrl: (settings.arguments as List)[0],
            clickedIndex: (settings.arguments as List)[1] as int,
          ),
          settings,
        );
      case "/a101GridView":
        return _generateRoute(
          A101GridView(categoryUrl: settings.arguments as String),
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
