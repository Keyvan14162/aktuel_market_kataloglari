import 'dart:async';
import 'package:aktuel_urunler_bim_a101_sok/data/a101_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/bim_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/bizim_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/sok_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/expansion_panel/custom_expansion_panel.dart';
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
  final List<Widget> _customExpansionPanelList = [];
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
            logoPath: constant_values.a101LogoPath,
            headerText: "A101 Güncel Katalogları",
            color: constant_values.a101Color,
            marketCode: constant_values.a101Code,
          ),
          divider(width, constant_values.a101Color),
          CustomExpansionPanel(
            dataFuture: BimClient().getBannerData(),
            logoPath: constant_values.bimLogoPath,
            headerText: "Bim Güncel Katalogları",
            color: constant_values.bimColor,
            marketCode: constant_values.bimCode,
          ),
          divider(width, constant_values.bimColor),
          CustomExpansionPanel(
            dataFuture: SokClient().getBannerData(),
            logoPath: constant_values.sokLogoPath,
            headerText: "Şok Güncel Katalogları",
            color: constant_values.sokColor,
            marketCode: constant_values.sokCode,
          ),
          divider(width, constant_values.sokColor),
          CustomExpansionPanel(
            dataFuture: BizimClient().getBannerData(),
            logoPath: constant_values.bizimLogoPath,
            headerText: "Bizim Güncel Katalogları",
            color: constant_values.bizimColor,
            marketCode: constant_values.bizimCode,
          ),
          divider(width, constant_values.bizimColor),
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
