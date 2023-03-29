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
import 'package:shimmer/shimmer.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants/constant_values.dart'
    as constant_values;

class CustomExpansionPanel extends StatefulWidget {
  const CustomExpansionPanel(
      {required this.dataFuture,
      required this.logoPath,
      required this.headerText,
      required this.color,
      required this.marketCode,
      super.key});

  final Future dataFuture;
  final String logoPath;
  final String headerText;
  final Color color;
  final int marketCode;

  @override
  State<CustomExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return expansionPanel(
      widget.dataFuture,
      width,
      widget.logoPath,
      widget.headerText,
      widget.color,
      widget.marketCode,
    );
  }

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
                        switch (marketCode) {
                          case constant_values.a101Code:
                            brochurePageImagesFuture =
                                A101Client().getBrochurePageImageUrls(
                              data[index].catagoryUrl.toString(),
                            );
                            break;
                          case constant_values.bimCode:
                            brochurePageImagesFuture =
                                brochurePageImagesFuture =
                                    BimClient().getBrochurePageImageUrls(index);
                            break;
                          case constant_values.sokCode:
                            brochurePageImagesFuture =
                                SokClient().getBrochurePageImageUrls(
                              data[index].catagoryUrl.toString(),
                            );
                            break;
                          case constant_values.bizimCode:
                            brochurePageImagesFuture =
                                BizimClient().getBrochurePageImageUrls(
                              data[index].catagoryUrl.toString(),
                            );
                            break;
                          case constant_values.floCode:
                            brochurePageImagesFuture =
                                FloClient().getBrochurePageImageUrls(
                              data[index].catagoryUrl.toString(),
                            );
                            break;
                          case constant_values.lcCode:
                            brochurePageImagesFuture =
                                LcClient().getBrochurePageImageUrls(
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
                            brochurePageImagesFuture =
                                SokClient().getBrochurePageImageUrls(
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
}
