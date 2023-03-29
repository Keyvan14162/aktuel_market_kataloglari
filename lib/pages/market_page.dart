import 'dart:async';
import 'package:aktuel_urunler_bim_a101_sok/data/a101_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/bim_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/bizim_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/sok_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/custom_expansion_panel.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/lottie_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants/constant_values.dart'
    as constant_values;

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _HomePageState();
}

class _HomePageState extends State<MarketPage> with TickerProviderStateMixin {
  late StreamSubscription<InternetConnectionStatus> internetConnectionListener;

  @override
  void initState() {
    super.initState();
    internetConnectionListener =
        InternetConnectionChecker().onStatusChange.listen((status) {
      ScaffoldMessenger.of(context).clearSnackBars();
      setState(() {});
    });
  }

  @override
  void dispose() {
    internetConnectionListener.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    connectionStatusSnackbar();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white70,
        ),

        title: Row(
          children: [
            IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: const Icon(Icons.menu),
            ),
            const SizedBox(
              width: 40,
            ),
            const Text(
              "Aktüel Market Katalogları",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,

        backgroundColor: Theme.of(context).primaryColor,
        // elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: LottieMain(lottiePath: "assets/lotties/walking_man.json"),
            ),
            CustomExpansionPanel(
                dataFuture: A101Client().getBannerData(),
                logoPath: constant_values.a101LogoPath,
                headerText: "A101 Güncel Katalogları",
                color: constant_values.a101Color,
                marketCode: constant_values.a101Code),
            divider(width, constant_values.a101Color),
            CustomExpansionPanel(
                dataFuture: BimClient().getBannerData(),
                logoPath: constant_values.bimLogoPath,
                headerText: "Bim Güncel Katalogları",
                color: constant_values.bimColor,
                marketCode: constant_values.bimCode),
            divider(width, constant_values.bimColor),
            CustomExpansionPanel(
                dataFuture: SokClient().getBannerData(),
                logoPath: constant_values.sokLogoPath,
                headerText: "Şok Güncel Katalogları",
                color: constant_values.sokColor,
                marketCode: constant_values.sokCode),
            divider(width, constant_values.sokColor),
            CustomExpansionPanel(
                dataFuture: BizimClient().getBannerData(),
                logoPath: constant_values.bizimLogoPath,
                headerText: "Bizim Güncel Katalogları",
                color: constant_values.bizimColor,
                marketCode: constant_values.bizimCode),
            divider(width, constant_values.bizimColor),
          ],
        ),
      ),
    );
  }

/*
  Widget expansionPanel(Future dataFuture, double width, String logoPath,
      String headerText, Color color, int marketCode) {
    return FutureBuilder(
      future: dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data != null) {
          List<BannerModel> data = snapshot.data as List<BannerModel>;

          return Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
            child: ExpansionPanelList.radio(
              elevation: 8,
              children: [
                ExpansionPanelRadio(
                  value: 1,
                  headerBuilder: (context, isExpanded) {
                    return SizedBox(
                      //width: double.infinity,
                      height: width / 5,
                      child: Row(
                        children: [
                          // logo
                          Container(
                            width: width / 4,
                            padding: const EdgeInsets.fromLTRB(6, 4, 2, 4),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Image.asset(
                              logoPath,
                              fit: BoxFit.contain,
                            ),
                          ),
                          //text
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  headerText,
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w900,
                                    color: color,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  body: SizedBox(
                    width: double.infinity,
                    height: width / 2 * 1.6,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        Future brochurePageImagesFuture;
                        if (marketCode == 0) {
                          brochurePageImagesFuture =
                              A101Client().getBrochurePageImageUrls(
                            data[index].catagoryUrl.toString(),
                          );
                        } else if (marketCode == 1) {
                          brochurePageImagesFuture =
                              BimClient().getBrochurePageImageUrls(index);
                        } else if (marketCode == 2) {
                          brochurePageImagesFuture =
                              SokClient().getBrochurePageImageUrls(
                            data[index].catagoryUrl.toString(),
                          );
                        } else if (marketCode == 3) {
                          brochurePageImagesFuture =
                              BizimClient().getBrochurePageImageUrls(
                            data[index].catagoryUrl.toString(),
                          );
                        } else if (marketCode == 4) {
                          brochurePageImagesFuture =
                              FloClient().getBrochurePageImageUrls(
                            data[index].catagoryUrl.toString(),
                          );
                        } else if (marketCode == 5) {
                          brochurePageImagesFuture =
                              LcClient().getBrochurePageImageUrls(
                            data[index].catagoryUrl.toString(),
                          );
                        } else {
                          brochurePageImagesFuture =
                              DefactoClient().getBrochurePageImageUrls(
                            data[index].catagoryUrl.toString(),
                          );
                        }

                        return expansionPanelItem(
                          data,
                          index,
                          width,
                          color,
                          brochurePageImagesFuture,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.2),
            highlightColor: Colors.grey.withOpacity(0.05),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: Container(
                height: width / 5,
                color: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }

  Widget expansionPanelItem(List<BannerModel> data, int index, double width,
      Color color, Future brochurePageImagesFuture) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/gridPage", arguments: [
          brochurePageImagesFuture,
          data[index].date ?? "hata",
          color,
        ]);
      },
      child: Container(
        width: width / 2,
        color: Colors.white,
        child: Column(
          children: [
            // category text
            Padding(
              padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Center(
                    child: Text(
                      data[index].categoryName ?? "hata",
                      overflow: TextOverflow.fade,
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
            // date
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 4),
                child: Text(
                  data[index].date ?? "hata",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // image
            Expanded(
              child: CachedNetworkImage(
                imageUrl: data[index].catalogImgUrl ?? "",
              ),
            ),
          ],
        ),
      ),
    );
  }
*/
  Center divider(double width, Color color) {
    return Center(
      child: Container(
        width: width - 16,
        height: 8,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  connectionStatusSnackbar() async {
    await (InternetConnectionChecker().hasConnection).then(
      (value) {
        if (!value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 100),
              backgroundColor: Colors.white,
              content: const Text(
                "İnternet Bağlantısı Bulunamadı",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              action: SnackBarAction(
                label: 'Yenile',
                onPressed: () {
                  setState(() {});
                },
              ),
            ),
          );
        }
      },
    );
  }
}
