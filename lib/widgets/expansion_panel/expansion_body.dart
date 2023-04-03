import 'package:aktuel_urunler_bim_a101_sok/data/a101_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/bim_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/bizim_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/defacto_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/flo_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/lc_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/data/sok_client.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/banner_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants/constant_values.dart'
    as constant_values;

class ExpansionBody extends StatelessWidget {
  final List<BannerModel> data;
  final double width;
  final Color color;
  final int marketCode;

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
            case constant_values.a101Code:
              brochurePageImagesFuture = A101Client().getBrochurePageImageUrls(
                data[index].catagoryUrl.toString(),
              );
              break;
            case constant_values.bimCode:
              brochurePageImagesFuture = brochurePageImagesFuture =
                  BimClient().getBrochurePageImageUrls(index);
              break;
            case constant_values.sokCode:
              brochurePageImagesFuture = SokClient().getBrochurePageImageUrls(
                data[index].catagoryUrl.toString(),
              );
              break;
            case constant_values.bizimCode:
              brochurePageImagesFuture = BizimClient().getBrochurePageImageUrls(
                data[index].catagoryUrl.toString(),
              );
              break;
            case constant_values.floCode:
              brochurePageImagesFuture = FloClient().getBrochurePageImageUrls(
                data[index].catagoryUrl.toString(),
              );
              break;
            case constant_values.lcCode:
              brochurePageImagesFuture = LcClient().getBrochurePageImageUrls(
                data[index].catagoryUrl.toString(),
              );
              break;
            case constant_values.defactoCode:
              brochurePageImagesFuture =
                  DefactoClient().getBrochurePageImageUrls(
                data[index].catagoryUrl.toString(),
              );
              break;
            default:
              brochurePageImagesFuture = SokClient().getBrochurePageImageUrls(
                data[index].catagoryUrl.toString(),
              );
          }
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
        },
      ),
    );
  }
}
