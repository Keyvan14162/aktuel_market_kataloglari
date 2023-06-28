import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants/enums.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/a101_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/bim_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/kataloglar_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/banner_model.dart';
import 'package:aktuel_urunler_bim_a101_sok/pages/old/store_page_old.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/expansion_panel/custom_expansion_panel.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreLoadingPage extends StatelessWidget {
  const StoreLoadingPage({required this.stores, super.key});
  final List<StoreCode> stores;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: createExpansionPanelItems(stores, 1.sw),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Loadings.manWalkinLottie();

              case ConnectionState.none:
                return Loadings.manWalkinLottie();

              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.data != null) {
                  return StorePageOld(
                    expansionPanelItemsList: snapshot.data as List<Widget>,
                  );
                } else {
                  return Loadings.manWalkinLottie();
                }
              default:
                return Loadings.manWalkinLottie();
            }
          },
        ),
      ),
    );
  }

  Future<List<Widget>> createExpansionPanelItems(
    List<StoreCode> storeCodeList,
    double width,
  ) async {
    List<Widget> expansionPanelList = [];

    for (var storeCode in storeCodeList) {
      switch (storeCode) {
        case StoreCode.a101:
          await A101Client()
              .getBannerData()
              .then(
                (List<BannerModel> bannerModelsList) => expansionPanelList.add(
                  CustomExpansionPanel(
                    bannerModelsList: bannerModelsList,
                    logoPath: Constants.a101LogoPath,
                    headerText: "A101 Aktüel Katalogları",
                    color: Constants.a101Color,
                    storeCode: storeCode,
                  ),
                ),
              )
              .onError(
                (error, stackTrace) => debugPrint(
                  error.toString(),
                ),
              );
          break;
        case StoreCode.bim:
          await BimClient()
              .getBannerData()
              .then(
                (List<BannerModel> bannerModelsList) => expansionPanelList.add(
                  CustomExpansionPanel(
                    bannerModelsList: bannerModelsList,
                    logoPath: Constants.bimLogoPath,
                    headerText: "Bim Aktüel Katalogları",
                    color: Constants.bimColor,
                    storeCode: storeCode,
                  ),
                ),
              )
              .onError(
                (error, stackTrace) => debugPrint(
                  error.toString(),
                ),
              );
          break;
        case StoreCode.sok:
          await KataloglarClient()
              .getBannerData(Constants.sokBannerPageUrl)
              .then(
                (List<BannerModel> bannerModelsList) => expansionPanelList.add(
                  CustomExpansionPanel(
                    bannerModelsList: bannerModelsList,
                    logoPath: Constants.sokLogoPath,
                    headerText: "Şok Aktüel Katalogları",
                    color: Constants.sokColor,
                    storeCode: storeCode,
                  ),
                ),
              )
              .onError(
                (error, stackTrace) => debugPrint(
                  error.toString(),
                ),
              );
          break;
        case StoreCode.bizim:
          await KataloglarClient()
              .getBannerData(Constants.bizimBannerPageUrl)
              .then(
                (List<BannerModel> bannerModelsList) => expansionPanelList.add(
                  CustomExpansionPanel(
                    bannerModelsList: bannerModelsList,
                    logoPath: Constants.bizimLogoPath,
                    headerText: "Bizim Aktüel Katalogları",
                    color: Constants.bizimColor,
                    storeCode: storeCode,
                  ),
                ),
              )
              .onError(
                (error, stackTrace) => debugPrint(
                  error.toString(),
                ),
              );
          break;
        case StoreCode.flo:
          await KataloglarClient()
              .getBannerData(Constants.floBannerPageUrl)
              .then(
                (List<BannerModel> bannerModelsList) => expansionPanelList.add(
                  CustomExpansionPanel(
                    bannerModelsList: bannerModelsList,
                    logoPath: Constants.floLogoPath,
                    headerText: "Flo Aktüel Katalogları",
                    color: Constants.floColor,
                    storeCode: storeCode,
                  ),
                ),
              )
              .onError(
                (error, stackTrace) => debugPrint(
                  error.toString(),
                ),
              );
          break;
        case StoreCode.lc:
          await KataloglarClient()
              .getBannerData(Constants.lcBannerPageUrl)
              .then(
                (List<BannerModel> bannerModelsList) => expansionPanelList.add(
                  CustomExpansionPanel(
                    bannerModelsList: bannerModelsList,
                    logoPath: Constants.lcLogoPath,
                    headerText: "LcWaikiki Aktüel Katalogları",
                    color: Constants.lcColor,
                    storeCode: storeCode,
                  ),
                ),
              )
              .onError(
                (error, stackTrace) => debugPrint(
                  error.toString(),
                ),
              );
          break;
        case StoreCode.defacto:
          await KataloglarClient()
              .getBannerData(Constants.defactoBannerPageUrl)
              .then(
                (List<BannerModel> bannerModelsList) => expansionPanelList.add(
                  CustomExpansionPanel(
                    bannerModelsList: bannerModelsList,
                    logoPath: Constants.defactoLogoPath,
                    headerText: "Defacto Aktüel Katalogları",
                    color: Constants.defactoColor,
                    storeCode: storeCode,
                  ),
                ),
              )
              .onError(
                (error, stackTrace) => debugPrint(
                  error.toString(),
                ),
              );
          break;
        default:
      }
    }
    return expansionPanelList;
  }
}
