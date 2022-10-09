import 'package:aktuel_urunler_bim_a101_sok/helpers/a101.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants.dart' as Constants;
import 'package:photo_view/photo_view.dart';

class BannerPage extends StatefulWidget {
  const BannerPage(
      {required this.brochurePageUrls,
      required this.clickedIndex,
      required this.color,
      super.key});
  final List<String> brochurePageUrls;
  final int clickedIndex;
  final Color color;

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<CachedNetworkImage> imageList = [];

  @override
  void initState() {
    _current = widget.clickedIndex;

    widget.brochurePageUrls.forEach((url) {
      imageList.add(
        CachedNetworkImage(imageUrl: url),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: widget.color,
        /*
        title: Text(
          widget.categoryUrl.split("/")[3].replaceAll("-", " ").toUpperCase(),
        ),
        */
      ),
      body: Container(
        child: Column(
          children: [
            // img
            Expanded(
              child: CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  //aspectRatio: 1.0,
                  initialPage: _current,
                  height: MediaQuery.of(context).size.height,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 0.8,
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,

                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items: widget.brochurePageUrls
                    .map(
                      (url) => Container(
                        child: Hero(
                          tag: url,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                "/detailPage",
                                arguments: [widget.brochurePageUrls, _current],
                              ).then(
                                (value) {
                                  if (_current != value as int) {
                                    setState(() {
                                      _current = value;
                                      _controller.jumpToPage(_current);
                                    });
                                  }
                                },
                              );
                            },
                            onVerticalDragEnd: (details) {
                              Navigator.of(context).pop();
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              child: imageList[
                                  widget.brochurePageUrls.indexOf(url)],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            // durum indikatoru
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.brochurePageUrls.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    try {
                      _controller.animateToPage(entry.key);
                    } catch (e) {
                      print("$e Durum İndikatörü Hata");
                    }
                  },
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : widget.color)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
