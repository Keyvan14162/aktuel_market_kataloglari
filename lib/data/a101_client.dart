import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class A101Client {
  Future<List<BannerModel>> getBannerData() async {
    List<BannerModel> bannerElements = [];
    var response = await http.Client().get(
      Uri.parse(Constants.a101BannerPageUrl),
    );
    //If the http request is successful the statusCode will be 200
    if (response.statusCode == 200) {
      var document = parse(response.body);
      for (var li in document
          .getElementsByClassName("brochures-list")[0]
          .children[0]
          .children) {
        List list = li.children[0].children[1].text.trim().split("\n");
        String date = "${list[0].trim()} ${list[2].trim()}";

        bannerElements.add(
          BannerModel(
            li.children[0].attributes["href"]
                ?.replaceAll("/afisler", "")
                .replaceAll("-", " ")
                .replaceAll("/", "")
                .toUpperCase(),
            date,
            li.children[0].children[2].attributes["src"],
            bannerUrl: li.children[0].attributes["href"],
          ),
        );
      }

      return bannerElements;
    } else {
      debugPrint("getA101BannerImageUrls 200 değil");
      return [];
    }
  }

  Future<List<String>> getBrochurePageImageUrls(String url) async {
    List<String> brochurePages = [];

    var response = await http.Client().get(
      Uri.parse("https://www.a101.com.tr${url.trim()}"),
    );
    //If the http request is successful the statusCode will be 200
    if (response.statusCode == 200) {
      var document = parse(response.body);
      document.getElementsByClassName("view-area").forEach((element) {
        //   print("${element.children[0].hasChildNodes()} - $i");
        // i++;
        try {
          brochurePages.add(element.children[0].attributes["src"].toString());
        } catch (e) {
          debugPrint("Sayfa cekilemedi");
        }
      });
      return brochurePages;
    } else {
      debugPrint("getBrochurePageImageUrls 200 değil");
      return [];
    }
  }
}
