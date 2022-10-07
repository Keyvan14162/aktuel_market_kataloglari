import 'package:aktuel_urunler_bim_a101_sok/helpers/a101.dart';
import 'package:aktuel_urunler_bim_a101_sok/helpers/bim.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/a101_banner_model.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/bim_banner_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'constants.dart' as Constants;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double headerHeight = 72;
  final EdgeInsetsGeometry headerPadding =
      const EdgeInsets.fromLTRB(10, 10, 0, 10);

  @override
  Widget build(BuildContext context) {
    Bim().getBimBannerData();
    return Scaffold(
      // Kaldirilabilir
      appBar: AppBar(
        title: const Text("Popüler Mağazalar"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // A 101
            Container(
              height: headerHeight,
              child: Padding(
                padding: headerPadding,
                child: Row(
                  children: [
                    Image.asset("assets/images/a101_logo.png"),
                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "A·101 Güncel Katalogları",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: Constants.A101_COLOR,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: A101().getA101BannerImageUrls(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<A101BannerModel> banners =
                      snapshot.data as List<A101BannerModel>;

                  return Container(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: banners.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              "/a101GridView",
                              arguments:
                                  "https://www.a101.com.tr${banners[index].catagoryUrl}",
                            );
                          },
                          child: Container(
                            color: Colors.grey.shade200,
                            child: Column(
                              children: [
                                // badge image
                                CachedNetworkImage(
                                  imageUrl:
                                      banners[index].badgeImgUrl.toString(),
                                  width: 100,
                                  height: 40,
                                ),

                                const SizedBox(
                                  height: 8,
                                ),
                                // date text
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 8, 2),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 2, 8, 8),
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
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        banners[index].bannerImgUrl.toString(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: LinearProgressIndicator(
                        // color
                        ),
                  );
                }
              },
            ),

            // BİM
            Container(
              height: headerHeight,
              child: Padding(
                padding: headerPadding,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/bim_logo.png",
                    ),
                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "BİM Güncel Katalogları",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: Constants.BIM_COLOR,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: Bim().getBimBannerData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<BimBannerModel> banners =
                      snapshot.data as List<BimBannerModel>;

                  return Container(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: banners.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            /*
                            Navigator.of(context).pushNamed(
                              "/a101GridView",
                              arguments:
                                  "https://www.a101.com.tr${banners[index].catagoryUrl}",
                            );
                            */
                          },
                          child: Container(
                            color: Colors.grey.shade200,
                            child: Column(
                              children: [
                                // week text
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Constants.BIM_COLOR,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: Text(
                                          banners[index].category!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                // date
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 16, 8, 4),
                                  child: Text(
                                    banners[index].date!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // banner image
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        left: BorderSide(
                                          width: 32.0,
                                          color: Colors.white,
                                        ),
                                        right: BorderSide(
                                          width: 32.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: banners[index]
                                          .bannerImgUrl
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: LinearProgressIndicator(
                        // color
                        ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
