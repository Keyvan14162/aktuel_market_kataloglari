import 'package:aktuel_urunler_bim_a101_sok/helpers/a101.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    A101().getA101BannerImageUrls();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Popüler Mağazalar"),
        ),
        body: Row(
          children: [
            Text("A 101"),
          ],
        ));
  }
}
