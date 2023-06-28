import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/store_model.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/store_page/banner_grid.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/store_page/custom_tabbar.dart';
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({required this.stores, super.key});
  final List<StoreModel> stores;

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.stores.length, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.stores.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTabBar(
              stores: widget.stores,
              height: kToolbarHeight - Constants.defaultPadding,
              isScrollable: true,
              tabController: _tabController,
              isTabsSmall: false,
            ),
            CustomTabBar(
              stores: widget.stores,
              height: kToolbarHeight / 3,
              isScrollable: false,
              tabController: _tabController,
              isTabsSmall: true,
            ),
            Expanded(child: _tabBarView()),
          ],
        ),
      ),
    );
  }

  Widget _tabBarView() {
    List<Widget> bannerGridViewsList = [];
    for (var store in widget.stores) {
      bannerGridViewsList.add(
        BannerGridView(store: store),
      );
    }

    return TabBarView(
      controller: _tabController,
      children: bannerGridViewsList,
    );
  }
}
