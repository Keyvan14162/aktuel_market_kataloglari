import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpansionHeader extends StatelessWidget {
  const ExpansionHeader(
      {required this.logoPath,
      required this.headerText,
      required this.color,
      super.key});
  final String logoPath;
  final String headerText;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.2.sw,
      child: Row(
        children: [
          // logo
          Container(
            width: 0.25.sw,
            padding: const EdgeInsets.fromLTRB(6, 4, 2, 4),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(Constants.defaultBorderRadius),
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
              padding: const EdgeInsets.all(Constants.defaultPadding),
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
  }
}
