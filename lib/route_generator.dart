import 'package:aktuel_urunler_bim_a101_sok/constants/pages.dart';
import 'package:aktuel_urunler_bim_a101_sok/pages/banner_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/pages/detail_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/pages/grid_page.dart';
import 'package:aktuel_urunler_bim_a101_sok/pages/old/store_page_old.dart';
import 'package:aktuel_urunler_bim_a101_sok/pages/zoom_drawer_page.dart';
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
      case Pages.homePage:
        return _generateRoute(const ZoomDrawerScreen(), settings);

      case Pages.storePage:
        return _generateRoute(
          StorePageOld(
              expansionPanelItemsList: settings.arguments as List<Widget>),
          settings,
        );

      case Pages.bannerPage:
        return _generateRoute(
          BannerPage(
            brochurePageUrls: (settings.arguments as List)[0] as List<String>,
            clickedIndex: (settings.arguments as List)[1] as int,
            color: (settings.arguments as List)[2] as Color,
          ),
          settings,
        );

      case Pages.gridPage:
        return _generateRoute(
          GridPage(
            brochurePageImagesFuture: (settings.arguments as List)[0] as Future,
            date: (settings.arguments as List)[1] as String,
            color: (settings.arguments as List)[2] as Color,
          ),
          settings,
        );

      case Pages.detailPage:
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
