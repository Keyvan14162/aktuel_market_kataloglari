import 'package:aktuel_urunler_bim_a101_sok/models/bim_banner_model.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class Bim {
  getBimBannerData() async {
    var response = await http.Client().get(
      Uri.parse("https://www.bim.com.tr/Categories/680/afisler.aspx"),
    );

    if (response.statusCode == 200) {
      List<BimBannerModel> banners = [];
      var document = parse(response.body);

      document
          .getElementsByClassName("no-gutters")[1]
          .children
          .forEach((element) {
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

            banners.add(
              BimBannerModel(
                "GEÇEN HAFTA",
                element.getElementsByClassName("subTabArea")[0].text.trim(),
                "https://www.bim.com.tr${element.getElementsByTagName("img")[1].attributes["src"]}",
                imgUrls,
              ),
            );
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

            banners.add(
              BimBannerModel(
                "BU HAFTA",
                element.getElementsByClassName("subTabArea")[0].text.trim(),
                "https://www.bim.com.tr${element.getElementsByTagName("img")[1].attributes["src"]}",
                imgUrls,
              ),
            );
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
            banners.add(
              BimBannerModel(
                "GELECEK HAFTA",
                element.getElementsByClassName("subTabArea")[0].text.trim(),
                "https://www.bim.com.tr${element.getElementsByTagName("img")[1].attributes["src"]}",
                imgUrls,
              ),
            );
          }
        } catch (e) {
          print("Bim sayfalar cekilirken hata");
        }
      });
      return banners;
    }
  }
}
