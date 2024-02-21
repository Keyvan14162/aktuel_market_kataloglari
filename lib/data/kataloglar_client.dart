import 'package:aktuel_urunler_bim_a101_sok/constants/resolve_date.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

// KATALOGLAR.COM WEBSITESINDEN CEKILEN MAGAZALAR ICIN

class KataloglarClient {
  _getPageUrls(String url) async {
    var response = await http.Client().get(
      Uri.parse(url),
    );
    List<String> pageUrls = [];
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var buttonList =
          document.getElementsByClassName("pages-btn-group")[0].children;
      // print(buttonList[buttonList.length - 2].text);

      try {
        pageUrls.add(
            "https://www.kataloglar.com.tr/${document.getElementsByClassName("pages-btn-group")[0].children[0].attributes["href"]}");
        for (var i = 2;
            i < int.parse(buttonList[buttonList.length - 2].text);
            i++) {
          pageUrls.add(
              "https://www.kataloglar.com.tr/${buttonList[1].attributes["href"]!.substring(0, buttonList[1].attributes["href"]!.length - 1) + i.toString()}");
        }
      } catch (e) {
        debugPrint(e.toString());
      }

      return pageUrls;
    }
  }

  Future<List<BannerModel>> getBannerData(String bannerPageUrl) async {
    var response = await http.Client().get(
      Uri.parse(bannerPageUrl),
    );

    if (response.statusCode == 200) {
      var document = parse(response.body);
      List<BannerModel> banners = [];
      try {
        for (var element in document
                .getElementsByClassName("page-body")[0]
                .children[0] // leatky-grid
                .children[0]
                .children // row
            ) {
          if (!(element.className.contains("hidden-xs") ||
              element.className.contains("hidden-sm") ||
              element.className.contains("visible-xs") ||
              element.className.contains("hidden-sm"))) {
            if (!element.children[1].className.contains("old")) {
              // element.children[1] =  div class="grid-item box blue "
              var gridItem = element.children[1];
              String imgAttributes =
                  gridItem.getElementsByTagName("img")[0].attributes.toString();

              String brochurePageUrl =
                  "https://www.kataloglar.com.tr${element.getElementsByTagName("a")[0].attributes["href"]}";

              String imgUrl = "";

              if (imgAttributes.contains("data-src")) {
                imgUrl = gridItem
                    .getElementsByTagName("img")[0]
                    .attributes["data-src"]
                    .toString();
              } else {
                imgUrl = gridItem
                    .getElementsByTagName("img")[0]
                    .attributes["src"]
                    .toString();
              }

              String fullDateString =
                  gridItem.children[0].attributes["title"] ?? "";
              int indexOfFirstDot = fullDateString.indexOf(".");
              String date =
                  "${toRevolveDate(fullDateString.substring(indexOfFirstDot - 2, indexOfFirstDot + 8))} ve Sonrasında";

              banners.add(
                BannerModel(
                  "Yeni ve Güncel",
                  date,
                  imgUrl,
                  bannerUrl: brochurePageUrl,
                ),
              );
            }
          }
        }
      } catch (e) {
        print(e);
      }

      return banners;
    } else {
      return [];
    }
  }

  Future<List<String>> getBrochurePageImageUrls(String url) async {
    List<String> pageUrls = await _getPageUrls(url);

    List<String> brochurePageImgUrls = [];

    for (var pageUrl in pageUrls) {
      var response = await http.Client().get(
        Uri.parse(pageUrl),
      );
      if (response.statusCode == 200) {
        var document = parse(response.body);

        // img url
        brochurePageImgUrls.add(
          document
              .getElementsByClassName("letaky-grid-preview")[0]
              .children[0]
              .children[0]
              .attributes["data-src"]
              .toString(),
        );
      }
    }
    return brochurePageImgUrls;
  }
}
