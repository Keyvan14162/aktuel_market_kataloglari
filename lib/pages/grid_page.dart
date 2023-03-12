import 'package:aktuel_urunler_bim_a101_sok/widgets/comments.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants/constant_values.dart'
    as constants;

class GridPage extends StatefulWidget {
  const GridPage(
      {required this.brochurePageImagesFuture,
      required this.date,
      required this.color,
      super.key});
  final Future brochurePageImagesFuture;
  final String date;
  final Color color;

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.date,
        ),
      ),
      body: LayoutBuilder(
        builder: (p0, p1) {
          return Container(
            color: widget.color.withOpacity(0.1),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: p1.maxHeight),
                child: FutureBuilder(
                  future: widget.brochurePageImagesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData &&
                        snapshot.data != null) {
                      List<String> brochurePages =
                          snapshot.data as List<String>;
                      return SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // brochure pages
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: brochurePages.length,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent:
                                    MediaQuery.of(context).size.width / 3,
                                childAspectRatio: 1 / 1.5,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4,
                              ),
                              itemBuilder: (BuildContext ctx, index) {
                                // gridview items
                                return GestureDetector(
                                  onTap: () {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    Navigator.of(context)
                                        .pushNamed("/bannerPage", arguments: [
                                      brochurePages,
                                      index,
                                      widget.color
                                    ]);
                                  },
                                  onPanStart: (details) {
                                    Navigator.of(context)
                                        .pushNamed("/bannerPage", arguments: [
                                      brochurePages,
                                      index,
                                      constants.a101Color,
                                    ]);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(1, 2, 1, 0),
                                      // IMAGE
                                      child: Hero(
                                        tag: brochurePages[index],
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
                            ),

                            // comments
                            Comments(
                              brochureDateText: widget.date,
                              color: widget.color,
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
