import 'package:aktuel_urunler_bim_a101_sok/constants/enums.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants/pages.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/a101_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/bim_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/kataloglar_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/banner_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart'
    as constant_values;

class ExpansionBody extends StatelessWidget {
  final List<BannerModel> data;
  final double width;
  final Color color;
  final MarketCode marketCode;

  const ExpansionBody(
      {required this.data,
      required this.width,
      required this.color,
      required this.marketCode,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: width / 2 * 1.6,
      child: ListView.builder(
        clipBehavior: Clip.none,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          Future brochurePageImagesFuture;
          switch (marketCode) {
            case MarketCode.a101:
              brochurePageImagesFuture = A101Client().getBrochurePageImageUrls(
                data[index].catagoryUrl.toString(),
              );
              break;
            case MarketCode.bim:
              brochurePageImagesFuture = brochurePageImagesFuture =
                  BimClient().getBrochurePageImageUrls(index);
              break;
            default:
              brochurePageImagesFuture =
                  KataloglarClient().getBrochurePageImageUrls(
                data[index].catagoryUrl.toString(),
              );
          }
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Pages.gridPage, arguments: [
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
        },
      ),
    );
  }
}
