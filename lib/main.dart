import 'package:aktuel_urunler_bim_a101_sok/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.routeGenrator,
      title: 'Aktüel Ürünler - Bim A101 Şok',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    makeRequest();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text("data"),
        /* tindeo
        Image.network(
          "https://static0.tiendeo.com.tr/images/tiendas/6656/catalogos/181298/paginas/med3/00003.jpg",
        ),
        */
      ),
    );
  }

  makeRequest() async {
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
        print(li.children[0].children[2].attributes["src"]);
      });
    } else {
      print("200 dışı");
    }
  }
}
