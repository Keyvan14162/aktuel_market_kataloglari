import 'package:aktuel_urunler_bim_a101_sok/models/banner_model.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/expansion_panel/expansion_body.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/expansion_panel/expansion_header.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
              animationDuration: const Duration(milliseconds: 450),
              elevation: 8,
              children: [
                ExpansionPanelRadio(
                  value: 1,
                  headerBuilder: (context, isExpanded) {
                    return ExpansionHeader(
                        width: width,
                        logoPath: logoPath,
                        headerText: headerText,
                        color: color);
                  },
                  body: ExpansionBody(
                      data: data,
                      width: width,
                      color: color,
                      marketCode: marketCode),
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
}
