import 'package:aktuel_urunler_bim_a101_sok/helpers/a101.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants.dart' as Constants;
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';

class A101GridView extends StatefulWidget {
  const A101GridView(
      {required this.categoryUrl, required this.date, super.key});
  final String categoryUrl;
  final String date;

  @override
  State<A101GridView> createState() => _A101GridViewState();
}

class _A101GridViewState extends State<A101GridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.A101_COLOR,
        title: Text(
          widget.date,
        ),
      ),
      body: Container(
        color: Constants.A101_COLOR.withOpacity(0.1),
        child: FutureBuilder(
          future: A101().getBrochurePageImageUrls(widget.categoryUrl),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String> brochurePages = snapshot.data as List<String>;
              // grid view
              return GridView.builder(
                itemCount: brochurePages.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
                  childAspectRatio: 1 / 1.5,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (BuildContext ctx, index) {
                  // gridview items
                  return Hero(
                    tag: brochurePages[index],
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("/bannerPage", arguments: [
                          brochurePages,
                          index,
                          Constants.A101_COLOR,
                        ]);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(1, 2, 1, 0),
                          // IMAGE
                          child: CachedNetworkImage(
                            fit: BoxFit.contain,
                            imageUrl: brochurePages[index],
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
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
