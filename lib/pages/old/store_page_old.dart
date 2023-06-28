import 'package:aktuel_urunler_bim_a101_sok/widgets/loadings.dart';
import 'package:flutter/material.dart';

class StorePageOld extends StatefulWidget {
  const StorePageOld({required this.expansionPanelItemsList, super.key});
  final List<Widget> expansionPanelItemsList;

  @override
  State<StorePageOld> createState() => _HomePageState();
}

class _HomePageState extends State<StorePageOld> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Loadings.manWalkinLottie(),
            Column(
              children: widget.expansionPanelItemsList,
            ),
          ],
        ),
      ),
    );
  }
}
