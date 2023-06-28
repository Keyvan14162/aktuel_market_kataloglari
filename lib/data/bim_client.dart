import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class BimClient {
  Future<List<BannerModel>> getBannerData() async {
    List<BannerModel> data = [await _getAllData()][0][0];

    return data;
  }

  Future<List<String>> getBrochurePageImageUrls(int index) async {
    List<String> data = [await _getAllData()][0][1][index];
    data.removeAt(0);

    return data;
  }

  Future<List<dynamic>> _getAllData() async {
    var response = await http.Client().get(
      Uri.parse(Constants.bimBannerPageUrl),
    );

    if (response.statusCode == 200) {
      List<BannerModel> bannerData = [];
      List<List<String>> brochurePageImgUrls = [];

      var document = parse(response.body);

      for (var element
          in document.getElementsByClassName("no-gutters")[1].children) {
        // gecen hafta
        try {
          if (element.className.contains("grup1")) {
            List<String> imgUrls = [];

            element.getElementsByTagName("img").forEach((img) {
              String url = img.attributes["src"]!;
              // download icon'u almayalim
              if (!url.contains("templates")) {
                imgUrls.add(
                  "https://www.bim.com.tr$url".replaceAll("k_", ""),
                );
              }
            });

            bannerData.add(
              BannerModel(
                "GEÇEN HAFTA",
                element.getElementsByClassName("subTabArea")[0].text.trim(),
                "https://www.bim.com.tr${element.getElementsByTagName("img")[1].attributes["src"]}",
              ),
            );
            brochurePageImgUrls.add(imgUrls);
          } // bu hafta
          else if (element.className.contains("grup2")) {
            List<String> imgUrls = [];

            element.getElementsByTagName("img").forEach((img) {
              String url = img.attributes["src"]!;
              // download icon'u almayalim
              if (!url.contains("templates")) {
                imgUrls.add(
                  "https://www.bim.com.tr$url".replaceAll("k_", ""),
                );
              }
            });

            bannerData.add(
              BannerModel(
                "BU HAFTA",
                element.getElementsByClassName("subTabArea")[0].text.trim(),
                "https://www.bim.com.tr${element.getElementsByTagName("img")[1].attributes["src"]}",
              ),
            );
            brochurePageImgUrls.add(imgUrls);
          }
          // sonraki hafta
          else if (element.className.contains("grup3")) {
            List<String> imgUrls = [];

            element.getElementsByTagName("img").forEach((img) {
              String url = img.attributes["src"]!;
              // download icon'u almayalim
              if (!url.contains("templates")) {
                imgUrls.add(
                  "https://www.bim.com.tr$url".replaceAll("k_", ""),
                );
              }
            });
            bannerData.add(
              BannerModel(
                "GELECEK HAFTA",
                element.getElementsByClassName("subTabArea")[0].text.trim(),
                "https://www.bim.com.tr${element.getElementsByTagName("img")[1].attributes["src"]}",
              ),
            );
            brochurePageImgUrls.add(imgUrls);
          }
        } catch (e) {
          debugPrint("Bim sayfalar cekilirken hata");
        }
      }

      return [bannerData, brochurePageImgUrls];
    } else {
      return [];
    }
  }
}
