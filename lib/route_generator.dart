import 'package:aktuel_urunler_bim_a101_sok/widgets/banner_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/detail_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/a101/a101_grid_view.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/bim/bim_grid_view.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/sok/sok_grid_view.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/zoom_drawer_screen.dart';
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

      case "/bannerPage":
        return _generateRoute(
          BannerPage(
            brochurePageUrls: (settings.arguments as List)[0] as List<String>,
            clickedIndex: (settings.arguments as List)[1] as int,
            color: (settings.arguments as List)[2] as Color,
          ),
          settings,
        );
      case "/a101GridView":
        return _generateRoute(
          A101GridView(
            categoryUrl: (settings.arguments as List)[0] as String,
            date: (settings.arguments as List)[1] as String,
          ),
          settings,
        );
      case "/bimGridView":
        return _generateRoute(
          BimGridView(
            brochurePages: (settings.arguments as List)[0] as List<String>,
            date: (settings.arguments as List)[1] as String,
          ),
          settings,
        );
      case "/sokGridView":
        return _generateRoute(
          SokGridView(
            pageUrl: (settings.arguments as List)[0] as String,
            title: (settings.arguments as List)[1] as String,
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
