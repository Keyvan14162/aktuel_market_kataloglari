import 'package:aktuel_urunler_bim_a101_sok/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

// CIMRI.COM WEBSITESINDEN CEKILEN MAGAZALAR ICIN

class KataloglarClient {
  Future<List<BannerModel>> getBannerData(String bannerPageUrl) async {
    var response = await http.Client().get(
      Uri.parse(bannerPageUrl),
    );

    if (response.statusCode == 200) {
      var document = parse(response.body);
      List<BannerModel> banners = [];

      try {
        for (var element in document
            .getElementsByClassName("s1a29zcm-10 dbqLIu")[0]
            .children) {
          String brochurePageUrl =
              "https://www.cimri.com${element.getElementsByTagName("a")[0].attributes["href"]}";

          String imgUrl = element.children[0]
              .getElementsByTagName("img")[0]
              .attributes["src"]
              .toString();

          String date = element.children[0]
              .getElementsByClassName("s1ra91yk-7 fUPBCX")[0]
              .innerHtml
              .toString();

          String bannerName = element.children[0]
              .getElementsByClassName("s1ra91yk-8 jTsxrW")[0]
              .innerHtml
              .toString();

          banners.add(
            BannerModel(
              bannerName,
              date,
              imgUrl,
              bannerUrl: brochurePageUrl,
            ),
          );
        }
      } catch (e) {
        // print("${e}kataloglar client get banner data func");
      }
      banners = banners.reversed.toList();
      return banners;
    } else {
      return [];
    }
  }

  Future<List<String>> getBrochurePageImageUrls(String url) async {
    var response = await http.Client().get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      List<String> brochurePageImgUrls = [];
      var document = parse(response.body);

      try {
        for (var element in document
            .getElementsByClassName("s1e6b0v8-3 iFVIwI")[0]
            .children) {
          brochurePageImgUrls.add(element
              .getElementsByTagName("img")[0]
              .attributes["src"]
              .toString());
        }
      } catch (e) {
        debugPrint(e.toString());
      }

      return brochurePageImgUrls;
    } else {
      return [];
    }
  }
}
