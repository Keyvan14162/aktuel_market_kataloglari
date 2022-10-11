import 'package:aktuel_urunler_bim_a101_sok/helpers/a101.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants.dart' as Constants;

class BimGridView extends StatefulWidget {
  const BimGridView(
      {required this.brochurePages, required this.date, super.key});
  final List<String> brochurePages;
  final String date;

  @override
  State<BimGridView> createState() => _BimGridViewState();
}

class _BimGridViewState extends State<BimGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.date),
      ),
      body: Container(
        color: Constants.BIM_COLOR.withOpacity(0.1),
        child: GridView.builder(
          itemCount: widget.brochurePages.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
            childAspectRatio: 1 / 1.5,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (BuildContext ctx, index) {
            // gridview items
            return Hero(
              tag: widget.brochurePages[index],
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/bannerPage", arguments: [
                    widget.brochurePages,
                    index,
                    Constants.BIM_COLOR,
                  ]);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(1, 2, 1, 0),
                    // IMAGE
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: widget.brochurePages[index],
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
