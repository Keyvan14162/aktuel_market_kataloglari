import 'package:aktuel_urunler_bim_a101_sok/helpers/a101.dart';
import 'package:aktuel_urunler_bim_a101_sok/helpers/bim.dart';
import 'package:aktuel_urunler_bim_a101_sok/helpers/functions.dart';
import 'package:aktuel_urunler_bim_a101_sok/helpers/sok.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/a101_banner_model.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/bim_banner_model.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/sok_banner_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constants.dart' as Constants;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AnimationController _controller;
  final double headerHeight = 72;
  final EdgeInsetsGeometry headerPadding =
      const EdgeInsets.fromLTRB(10, 10, 0, 10);
  var sokShow = false;
  var sokTopPadding = 0.0;
  var sokBottomPadding = 0.0;
  var a101Show = false;
  var a101TopPadding = 0.0;
  var a101BottomPadding = 0.0;
  var bimShow = false;
  var bimTopPadding = 0.0;
  var bimBottomPadding = 0.0;

  var animationDuration = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Kaldirilabilir
      appBar: AppBar(
        title: const Text(
          "Popüler Mağazalar",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // A 101
            Stack(
              children: [
                AnimatedPadding(
                  padding: EdgeInsets.only(
                      top: a101TopPadding, bottom: a101BottomPadding),
                  duration: Duration(milliseconds: animationDuration),
                  curve: Curves.elasticOut,
                  child: FutureBuilder(
                    future: A101().getA101BannerImageUrls(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<A101BannerModel> banners =
                            snapshot.data as List<A101BannerModel>;

                        return a101Show
                            ? Container(
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
                                          arguments: [
                                            "https://www.a101.com.tr${banners[index].catagoryUrl}",
                                            // date text
                                            banners[index]
                                                .date
                                                .toString()
                                                .split("\n")[0]
                                                .trim(),
                                          ],
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            // badge image
                                            CachedNetworkImage(
                                              imageUrl: banners[index]
                                                  .badgeImgUrl
                                                  .toString(),
                                              width: 210,
                                              height: 40,
                                            ),

                                            const SizedBox(
                                              height: 8,
                                            ),
                                            // date text
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 8, 8, 2),
                                                child: Text(
                                                  banners[index]
                                                      .date
                                                      .toString()
                                                      .split("\n")[0]
                                                      .trim(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 2, 8, 8),
                                                child: Text(
                                                  banners[index]
                                                      .date
                                                      .toString()
                                                      .split("\n")[2]
                                                      .trim(),
                                                ),
                                              ),
                                            ),

                                            // banner image
                                            Expanded(
                                              child: CachedNetworkImage(
                                                imageUrl: banners[index]
                                                    .bannerImgUrl
                                                    .toString(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0, headerHeight, 0, 0),
                                child: Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Constants.A101_COLOR,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
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
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      a101Show = !a101Show;
                      a101TopPadding = a101TopPadding == 0 ? headerHeight : 0.0;
                      a101BottomPadding = a101BottomPadding == 0 ? 10 : 0.0;
                    });
                  },
                  child: Container(
                    color: Colors.white,
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
                          a101Show
                              ? const Icon(Icons.arrow_drop_up)
                              : const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            a101Show
                ? Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Constants.A101_COLOR,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                : const SizedBox(),

            // BİM
            Stack(
              children: [
                AnimatedPadding(
                  padding: EdgeInsets.only(
                      top: bimTopPadding, bottom: bimBottomPadding),
                  duration: Duration(milliseconds: animationDuration),
                  curve: Curves.elasticOut,
                  child: FutureBuilder(
                    future: Bim().getBimBannerData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<BimBannerModel> banners =
                            snapshot.data as List<BimBannerModel>;

                        return bimShow
                            ? Container(
                                height: 300,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: banners.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // first 2 pages are same sometimes, bcs of website html
                                        // so remove duplicates with to set and then to list

                                        Navigator.of(context).pushNamed(
                                          "/bimGridView",
                                          arguments: [
                                            banners[index]
                                                .imgUrls
                                                .toSet()
                                                .toList(),
                                            banners[index].date,
                                          ],
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            // category text
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      1, 0, 1, 0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                height: 40,
                                                decoration: const BoxDecoration(
                                                  color: Constants.BIM_COLOR,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(12),
                                                    bottomRight:
                                                        Radius.circular(12),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Center(
                                                    child: Text(
                                                      banners[index].category!,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                              height: 8,
                                            ),

                                            // date
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 16, 8, 4),
                                                child: Text(
                                                  banners[index].date!,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Center(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 2, 8, 8),
                                                child:
                                                    Text("Tarihinden İtibaren"),
                                              ),
                                            ),

                                            // banner image
                                            Expanded(
                                              child: CachedNetworkImage(
                                                imageUrl: banners[index]
                                                    .bannerImgUrl
                                                    .toString(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    bimShow = !bimShow;
                                    bimTopPadding =
                                        bimTopPadding == 0 ? headerHeight : 0.0;
                                    bimBottomPadding =
                                        bimBottomPadding == 0 ? 10 : 0.0;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0, headerHeight, 0, 0),
                                  child: Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          20,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: Constants.BIM_COLOR,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
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
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      bimShow = !bimShow;
                      bimTopPadding = bimTopPadding == 0 ? headerHeight : 0.0;
                      bimBottomPadding = bimBottomPadding == 0 ? 10 : 0.0;
                    });
                  },
                  child: Container(
                    color: Colors.white,
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
                          bimShow
                              ? const Icon(Icons.arrow_drop_up)
                              : const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bimShow
                ? Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Constants.BIM_COLOR,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                : const SizedBox(),

            // Sok
            Stack(
              children: [
                AnimatedPadding(
                  padding: EdgeInsets.only(
                      top: sokTopPadding, bottom: sokBottomPadding),
                  duration: Duration(milliseconds: animationDuration),
                  curve: Curves.elasticOut,
                  child: FutureBuilder(
                    future: Sok().getBannerUrls(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<SokBannerModel> banners =
                            snapshot.data as List<SokBannerModel>;

                        return sokShow
                            ? Container(
                                height: 300,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: banners.length,
                                  itemBuilder: (context, index) {
                                    String date = Functions().convertDateToText(
                                        banners[index]
                                            .title!
                                            .substring(
                                                0,
                                                banners[index]
                                                    .title!
                                                    .indexOf("-"))
                                            .trim());

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            "/sokGridView",
                                            arguments: [
                                              banners[index].brochurePageUrl,
                                              date
                                            ]);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            // title
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      1, 0, 1, 0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: 40,
                                                decoration: const BoxDecoration(
                                                  color: Constants.SOK_COLOR,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(12),
                                                    bottomRight:
                                                        Radius.circular(12),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Center(
                                                    child: Text(
                                                      "${banners[index].title!.substring(
                                                            banners[index]
                                                                .title!
                                                                .indexOf(
                                                                    "Hafta"),
                                                            banners[index]
                                                                .title!
                                                                .indexOf("bro"),
                                                          )}Broşürü",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                              height: 8,
                                            ),

                                            // date
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 16, 8, 4),
                                                child: Text(
                                                  date,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // tarihleri arasinda
                                            const Center(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 2, 8, 8),
                                                child:
                                                    Text("Tarihinden İtibaren"),
                                              ),
                                            ),

                                            // banner image
                                            Expanded(
                                              child: CachedNetworkImage(
                                                imageUrl: banners[index]
                                                    .bannerImgUrl
                                                    .toString(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0, headerHeight, 0, 0),
                                child: Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Constants.SOK_COLOR,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
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
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      sokShow = !sokShow;
                      sokTopPadding = sokTopPadding == 0 ? headerHeight : 0.0;
                      sokBottomPadding = sokBottomPadding == 0 ? 10 : 0.0;
                    });
                  },
                  child: Container(
                    color: Colors.white,
                    height: headerHeight,
                    child: Padding(
                      padding: headerPadding,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                            decoration: const BoxDecoration(
                              color: Constants.SOK_COLOR,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Image.asset(
                              "assets/images/sok_logo.png",
                            ),
                          ),
                          const Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "ŞOK Güncel Katalogları",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    color: Constants.SOK_COLOR,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          sokShow
                              ? const Icon(Icons.arrow_drop_up)
                              : const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            sokShow
                ? Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Constants.SOK_COLOR,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
