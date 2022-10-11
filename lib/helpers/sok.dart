import 'package:aktuel_urunler_bim_a101_sok/models/sok_banner_model.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class Sok {
  _getSokPageUrls(String url) async {
    var response = await http.Client().get(
      // https://www.kataloglar.com.tr/sok-market/haftann-arambadan-itibaren-05-10-2022-3550/
      Uri.parse(url),
    );
    List<String> pageUrls = [];
    if (response.statusCode == 200) {
      var document = parse(response.body);
      for (var element
          in document.getElementsByClassName("pages-btn-group")[0].children) {
        pageUrls
            .add("https://www.kataloglar.com.tr/${element.attributes["href"]}");
      }
      // remove last 2 add pages
      pageUrls.removeLast();
      pageUrls.removeLast();

      return pageUrls;
    }
  }

  getSokBrochurePageImgUrls(String url) async {
    List<String> pageUrls = await _getSokPageUrls(url);

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

  getBannerUrls() async {
    var response = await http.Client().get(
      Uri.parse("https://www.kataloglar.com.tr/sok-market/"),
    );
    if (response.statusCode == 200) {
      var document = parse(response.body);
      List<SokBannerModel> banners = [];

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
            // print(imgUrl);

            banners.add(
              SokBannerModel(
                element.children[0].children[0].attributes["title"],
                imgUrl,
                brochurePageUrl,
              ),
            );
          }
        }
      }
      return banners;
    }
  }
}

  /*
  getSokBrochurePagesUrls(String url) async {
    var response = await http.Client().get(
      // url
      Uri.parse(
          "https://www.akakce.com/brosurler/sok-5-ekim-2022-aktuel-katalogu-haftanin-firsatlari-23122"),
    );

    if (response.statusCode == 200) {
      var document = parse(response.body);
      document.getElementsByTagName("ul")[1].children.forEach((element) {
        try {
          if (element.children[0].toString() == "<html img>") {
            String imgTag = element.children[0].attributes["style"]!;
            var firstBracketIndex = imgTag.indexOf("(");
            var lastBracketIndex = imgTag.indexOf(")");
            print(imgTag.substring(firstBracketIndex + 1, lastBracketIndex));
          }
        } catch (e) {
          print("Sok sayfalar cekilirken hata");
        }
      });
    }
  }
  */

