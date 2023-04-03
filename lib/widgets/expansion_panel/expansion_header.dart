import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ExpansionHeader extends StatelessWidget {
  final double width;
  final String logoPath;
  final String headerText;
  final Color color;
  const ExpansionHeader(
      {required this.width,
      required this.logoPath,
      required this.headerText,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
