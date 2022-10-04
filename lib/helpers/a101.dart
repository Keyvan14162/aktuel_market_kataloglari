import 'package:aktuel_urunler_bim_a101_sok/models/a101_banner_model.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class A101 {
  List<A101_Banner_Model> bannerElements = [];
  getA101BannerImageUrls() async {
    var response = await http.Client().get(
      Uri.parse("https://www.a101.com.tr/afisler"),
    );
    //If the http request is successful the statusCode will be 200
    if (response.statusCode == 200) {
      var document = parse(response.body);
      document.getElementsByClassName("image0").length;
      document
          .getElementsByClassName("brochures-list")[0]
          .children[0]
          .children
          .forEach((li) {
        bannerElements.add(
          A101_Banner_Model(
            // afis img usteundeki badge img
            li.children[0].children[0].children[0].attributes["src"],
            // banner img url
            li.children[0].children[2].attributes["src"],
            // date text
            li.children[0].children[1].text.trim(),
          ),
        );
      });
      return bannerElements;
    } else {
      print("200 dışı");
      return [];
    }
  }
}
