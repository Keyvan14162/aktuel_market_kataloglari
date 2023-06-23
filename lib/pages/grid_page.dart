import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants/pages.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/comments.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/shimmer_custom.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
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
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // brochure pages
                              GridView.builder(
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
                                  return gridImgItem(
                                      context, brochurePages, index);
                                },
                              ),

                              // comments
                              Comments(
                                scrollDown: () {
                                  _scrollController.jumpTo(_scrollController
                                      .position.maxScrollExtent);
                                },
                                brochureDateText: widget.date,
                                color: widget.color,
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: loadingText(),
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

  GestureDetector gridImgItem(
      BuildContext context, List<String> brochurePages, int index) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        Navigator.of(context).pushNamed(Pages.bannerPage,
            arguments: [brochurePages, index, widget.color]);
      },
      child: Material(
        elevation: 4,
        child: Hero(
          tag: brochurePages[index],
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: brochurePages[index],
            placeholder: (context, url) =>
                ShimmerCustom.baseShimmer(widget.color),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  AnimatedTextKit loadingText() {
    return AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText(
          "Katalog yükleniyor...",
          textStyle: const TextStyle(fontSize: 16),
        ),
        TyperAnimatedText(
          "Lütfen bekleyin...",
          textStyle: const TextStyle(fontSize: 16),
        ),
        TyperAnimatedText(
          "Az kaldı...",
          textStyle: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
