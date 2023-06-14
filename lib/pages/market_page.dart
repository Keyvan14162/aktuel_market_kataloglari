import 'dart:async';
import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants/enums.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/a101_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/bim_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/kataloglar_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/expansion_panel/custom_expansion_panel.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/lottie_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
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
      ),
      body: ListView(
        addRepaintBoundaries: false,
        children: [
          const Center(
            child: LottieMain(
              lottiePath: "assets/lotties/walking_man.json",
            ),
          ),
          CustomExpansionPanel(
            dataFuture: A101Client().getBannerData(),
            logoPath: Constants.a101LogoPath,
            headerText: "A101 Güncel Katalogları",
            color: Constants.a101Color,
            marketCode: MarketCode.a101,
          ),
          divider(width, Constants.a101Color),
          CustomExpansionPanel(
            dataFuture: BimClient().getBannerData(),
            logoPath: Constants.bimLogoPath,
            headerText: "Bim Güncel Katalogları",
            color: Constants.bimColor,
            marketCode: MarketCode.bim,
          ),
          divider(width, Constants.bimColor),
          CustomExpansionPanel(
            dataFuture:
                KataloglarClient().getBannerData(Constants.sokBannerPageUrl),
            logoPath: Constants.sokLogoPath,
            headerText: "Şok Güncel Katalogları",
            color: Constants.sokColor,
            marketCode: MarketCode.sok,
          ),
          divider(width, Constants.sokColor),
          CustomExpansionPanel(
            dataFuture:
                KataloglarClient().getBannerData(Constants.bizimBannerPageUrl),
            logoPath: Constants.bizimLogoPath,
            headerText: "Bizim Güncel Katalogları",
            color: Constants.bizimColor,
            marketCode: MarketCode.bizim,
          ),
          divider(width, Constants.bizimColor),
        ],
      ),
    );
  }

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
