import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/store_model.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {required this.stores,
      required this.height,
      required this.isScrollable,
      required this.tabController,
      required this.isTabsSmall,
      super.key});

  final List<StoreModel> stores;
  final double height;
  final bool isScrollable;
  final TabController tabController;
  final bool isTabsSmall;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Constants.defaultPadding,
        Constants.defaultPadding,
        Constants.defaultPadding,
        isTabsSmall ? Constants.defaultPadding : 0,
      ),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(Constants.defaultBorderRadius),
        ),
        child: TabBar(
          isScrollable: isScrollable,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.defaultBorderRadius),
            color: Theme.of(context).primaryColor,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          controller: tabController,
          tabs: isTabsSmall ? createSmallTabs(stores) : createTabs(stores),
        ),
      ),
    );
  }

  List<Widget> createSmallTabs(List<StoreModel> stores) {
    List<Widget> tabs = [];
    for (var store in stores) {
      tabs.add(
        FittedBox(
          fit: BoxFit.contain,
          child: Text(store.storeName),
        ),
      );
    }
    return tabs;
  }

  List<Tab> createTabs(List<StoreModel> stores) {
    List<Tab> tabs = [];
    for (var store in stores) {
      tabs.add(_tab(
        store.logoPath,
        store.storeName,
      ));
    }
    return tabs;
  }

  Tab _tab(
    String logoPath,
    String storeName,
  ) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.only(top: Constants.defaultPadding / 3),
        child: Row(
          children: [
            Image.asset(
              logoPath,
              height: kToolbarHeight,
            ),
            const SizedBox(
              width: Constants.defaultPadding,
            ),
            FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                storeName,
              ),
            )
          ],
        ),
      ),
    );
  }
}
