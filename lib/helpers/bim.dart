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
        if (element.className.contains("grup1")) {
          banners.add(
            BimBannerModel(
              "GEÇEN HAFTA",
              element.getElementsByClassName("subTabArea")[0].text.trim(),
              "https://www.bim.com.tr${element.getElementsByTagName("img")[1].attributes["src"]}",
            ),
          );
        } else if (element.className.contains("grup2")) {
          banners.add(
            BimBannerModel(
              "BU HAFTA",
              element.getElementsByClassName("subTabArea")[0].text.trim(),
              "https://www.bim.com.tr${element.getElementsByTagName("img")[1].attributes["src"]}",
            ),
          );
        } else if (element.className.contains("grup3")) {
          banners.add(
            BimBannerModel(
              "GELECEK HAFTA",
              element.getElementsByClassName("subTabArea")[0].text.trim(),
              "https://www.bim.com.tr${element.getElementsByTagName("img")[1].attributes["src"]}",
            ),
          );
        }
      });
      return banners;
    }
  }
}

/*

  getBimBannerData() async {
    var response = await http.Client().get(
      Uri.parse("https://www.bim.com.tr/Categories/680/afisler.aspx"),
    );

    if (response.statusCode == 200) {
      List<BimBannerModel> banners = [];
      var document = parse(response.body);

      /*
      document.getElementsByClassName("tabButtonArea")[0].children.forEach((a) {
        // print(a.text); // tabbar textleri
      });
      */

      // displayler hep none
      document
          .getElementsByClassName("no-gutters")[1]
          .children
          .forEach((element) {
        // gecen hafta
        if (element.className.contains("grup1")) {
          print("gecen hafta");
          // print("tarih : ${element.children[0].text.trim()}");
          // tarih

          /*
          banners.add(BimBannerModel(
              "GEÇEN HAFTA",
              element.getElementsByClassName("subTabArea")[0].text.trim(),
              bannerImgUrl));

          */

          print(element.getElementsByClassName("subTabArea")[0].text.trim());
          element.getElementsByTagName("img").forEach((img) {
            // normal urlin basindaki k_ kaldırınca ana resimi veriyo
            // img.attributes["src"] null olabilirmis
            String url = img.attributes["src"]!;

            // download icon'u almayalim
            if (!url.contains("templates")) {
              String smallImageUrl = "https://www.bim.com.tr$url";

              String mainImgUrl = smallImageUrl.replaceAll("k_", "");
              print(mainImgUrl);
            }
          });
        } else if (element.className.contains("grup2")) {
          print("bu hafta");
        } else if (element.className.contains("grup3")) {
          print("gelecek hafta");
        }
      });

      /*
      print(document
          .getElementsByClassName("fancyboxImage")[0]
          .children[0]
          .attributes["src"]);
      */
    }
  }
*/
