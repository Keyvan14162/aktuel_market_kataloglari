import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants/enums.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/banner_model.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/expansion_panel/expansion_body.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/expansion_panel/expansion_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomExpansionPanel extends StatefulWidget {
  const CustomExpansionPanel(
      {required this.bannerModelsList,
      required this.logoPath,
      required this.headerText,
      required this.color,
      required this.storeCode,
      super.key});

  final List<BannerModel> bannerModelsList;
  final String logoPath;
  final String headerText;
  final Color color;
  final StoreCode storeCode;

  @override
  State<CustomExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {
  @override
  Widget build(BuildContext context) {
    return expansionPanel(
      widget.bannerModelsList,
      widget.logoPath,
      widget.headerText,
      widget.color,
      widget.storeCode,
    );
  }

  Widget expansionPanel(List<BannerModel> bannerModelList, String logoPath,
      String headerText, Color color, StoreCode storeCode) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Constants.defaultPadding,
              Constants.defaultPadding, Constants.defaultPadding, 0),
          child: ExpansionPanelList.radio(
            animationDuration: const Duration(milliseconds: 450),
            elevation: 8,
            children: [
              ExpansionPanelRadio(
                value: 1,
                headerBuilder: (context, isExpanded) {
                  return ExpansionHeader(
                    logoPath: logoPath,
                    headerText: headerText,
                    color: color,
                  );
                },
                body: ExpansionBody(
                  data: bannerModelList,
                  color: color,
                  storeCode: storeCode,
                ),
              ),
            ],
          ),
        ),
        divider(color),
      ],
    );
  }

  Center divider(Color color) {
    return Center(
      child: Container(
        width: 1.sw - 16,
        height: 8,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(Constants.defaultBorderRadius),
          ),
        ),
      ),
    );
  }
}
