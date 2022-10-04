import 'package:aktuel_urunler_bim_a101_sok/helpers/a101.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/a101_banner_model.dart';
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
        body: Column(
          children: [
            Text("A 101"),
            FutureBuilder(
              future: A101().getA101BannerImageUrls(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<A101_Banner_Model> banners =
                      snapshot.data as List<A101_Banner_Model>;

                  return Container(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: banners.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: Column(
                            children: [
                              // badge image
                              Image.network(
                                banners[index].badgeImgUrl.toString(),
                                width: 100,
                                height: 40,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              // date text
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                                child: Text(
                                  banners[index]
                                      .date
                                      .toString()
                                      .split("\n")[0]
                                      .trim(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                                child: Text(
                                  banners[index]
                                      .date
                                      .toString()
                                      .split("\n")[2]
                                      .trim(),
                                ),
                              ),
                              // banner image
                              Expanded(
                                child: Image.network(
                                  banners[index].bannerImgUrl.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Text("no data moruq");
                }
              },
            ),
          ],
        ));
  }
}
