import 'package:aktuel_urunler_bim_a101_sok/helpers/functions.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class FloClient {
  String bannerPageUrl = "https://www.kataloglar.com.tr/flo/";

  _getPageUrls(String url) async {
    var response = await http.Client().get(
      Uri.parse(url),
    );
    List<String> pageUrls = [];
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var buttonList =
          document.getElementsByClassName("pages-btn-group")[0].children;

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

  Future getBrochurePageImageUrls(String url) async {
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

  Future getBannerData() async {
    var response = await http.Client().get(
      Uri.parse(bannerPageUrl),
    );
    if (response.statusCode == 200) {
      var document = parse(response.body);
      List<BannerModel> banners = [];

      for (var element in document
          .getElementsByClassName("letaky-grid")[0]
          .children[0]
          .children) {
        if (!element.className.contains("hidden") &&
            !element.className.contains("visible")) {
          if (!element.children[0].className.contains("old")) {
            // banner Img Url
            String imgAttributes = element.children[0]
                .getElementsByTagName("img")[0]
                .attributes
                .toString();

            String brochurePageUrl =
                "https://www.kataloglar.com.tr${element.getElementsByTagName("a")[0].attributes["href"]}";

            String imgUrl = "";
            if (imgAttributes.contains("data-src")) {
              imgUrl = element.children[0]
                  .getElementsByTagName("img")[0]
                  .attributes["data-src"]
                  .toString();
            } else {
              imgUrl = element.children[0]
                  .getElementsByTagName("img")[0]
                  .attributes["src"]
                  .toString();
            }
            String date =
                " ${element.children[0].children[0].attributes["title"]?.substring(0, 23).split(" ")[0].substring(0, 2)} ${Functions().convertNumberToMonth(
              int.parse(element.children[0].children[0].attributes["title"]
                      ?.substring(0, 23)
                      .split(" ")[0]
                      .split(".")[1] ??
                  "1"),
            )} ";

            banners.add(
              BannerModel(
                "Yeni ve Güncel",
                date,
                imgUrl,
                catagoryUrl: brochurePageUrl,
              ),
            );
          }
        }
      }
      return banners;
    }
  }
}
