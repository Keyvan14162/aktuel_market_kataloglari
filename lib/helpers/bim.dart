import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class Bim {
  getBimData() async {
    var response = await http.Client().get(
      Uri.parse("https://www.bim.com.tr/Categories/680/afisler.aspx"),
    );
    //If the http request is successful the statusCode will be 200
    // li.children[0].attributes["href"],
    // afis img usteundeki badge img
    // li.children[0].children[0].children[0].attributes["src"],
    // banner img url
    // li.children[0].children[2].attributes["src"],
    // date text
    // li.children[0].children[1].text.trim(),
    if (response.statusCode == 200) {
      var document = parse(response.body);
      document.getElementsByClassName("tabButtonArea")[0].children.forEach((a) {
        // print(a.text); // tabbar textleri
      });

      // displayler hep none
      document
          .getElementsByClassName("no-gutters")[1]
          .children
          .forEach((element) {
        // gecen hafta
        if (element.className.contains("grup1")) {
          print("gecen hafta");

          print("-----------");
        } else if (element.className.contains("grup2")) {
          print("bu hafta");

          print("-----------");
        } else if (element.className.contains("grup3")) {
          print("gelecek hafta");
          ;
          print("-----------");
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
}
