import 'dart:async';
import 'package:aktuel_urunler_bim_a101_sok/data/defacto_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/flo_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/lc_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/custom_expansion_panel.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/lottie_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants/constant_values.dart'
    as constant_values;

class TextilePage extends StatefulWidget {
  const TextilePage({super.key});

  @override
  State<TextilePage> createState() => _TextilePageState();
}

class _TextilePageState extends State<TextilePage>
    with TickerProviderStateMixin {
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
              "Giyim Market Katalogları",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: LottieMain(
                lottiePath: "assets/lotties/walking_women.json",
              ),
            ),
            CustomExpansionPanel(
                dataFuture: FloClient().getBannerData(),
                logoPath: constant_values.floLogoPath,
                headerText: "Flo Güncel Ürünleri",
                color: constant_values.floColor,
                marketCode: constant_values.floCode),
            divider(width, constant_values.floColor),
            CustomExpansionPanel(
                dataFuture: LcClient().getBannerData(),
                logoPath: constant_values.lcLogoPath,
                headerText: "Lc Waikiki Ürünleri",
                color: constant_values.lcColor,
                marketCode: constant_values.lcCode),
            divider(width, constant_values.lcColor),
            CustomExpansionPanel(
                dataFuture: DefactoClient().getBannerData(),
                logoPath: constant_values.defactoLogoPath,
                headerText: "Defacto Güncel Ürünleri",
                color: constant_values.defactoColor,
                marketCode: constant_values.defactoCode),
            divider(width, constant_values.defactoColor),
          ],
        ),
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
