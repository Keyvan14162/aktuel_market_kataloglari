import 'package:aktuel_urunler_bim_a101_sok/constants/pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
  late CarouselController carouselController;
  List<CachedNetworkImage> imageList = [];

  @override
  void initState() {
    _current = widget.clickedIndex;
    carouselController = CarouselController();

    for (var url in widget.brochurePageUrls) {
      imageList.add(
        CachedNetworkImage(imageUrl: url),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: widget.color,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // img
            Expanded(
              child: CarouselSlider(
                carouselController: carouselController,
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
                      (url) => Hero(
                        tag: url,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              Pages.detailPage,
                              arguments: [widget.brochurePageUrls, _current],
                            ).then(
                              (value) {
                                if (_current != value as int) {
                                  setState(() {
                                    _current = value;
                                    carouselController.jumpToPage(_current);
                                  });
                                }
                              },
                            );
                          },
                          onVerticalDragEnd: (details) {
                            if (details.primaryVelocity == null) {
                              return;
                            }
                            if (details.primaryVelocity! < 0) {
                              // up
                              Navigator.of(context).pop();
                            }
                            if (details.primaryVelocity! > 0) {
                              // down
                              Navigator.of(context).pushNamed(
                                Pages.detailPage,
                                arguments: [widget.brochurePageUrls, _current],
                              ).then(
                                (value) {
                                  if (_current != value as int) {
                                    setState(() {
                                      _current = value;
                                      carouselController.jumpToPage(_current);
                                    });
                                  }
                                },
                              );
                            }
                          },
                          onScaleStart: (details) {
                            Navigator.of(context).pushNamed(
                              Pages.detailPage,
                              arguments: [widget.brochurePageUrls, _current],
                            ).then(
                              (value) {
                                if (_current != value as int) {
                                  setState(() {
                                    _current = value;
                                    carouselController.jumpToPage(_current);
                                  });
                                }
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            child:
                                imageList[widget.brochurePageUrls.indexOf(url)],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            pageIndicator(context),
          ],
        ),
      ),
    );
  }

  FittedBox pageIndicator(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.brochurePageUrls.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () {
              try {
                carouselController.animateToPage(entry.key);
              } catch (e) {
                debugPrint("$e Durum İndikatörü Hata");
              }
            },
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: const EdgeInsets.only(bottom: 8.0, left: 8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Theme.of(context).primaryColor)
                    .withOpacity(_current == entry.key ? 0.9 : 0.4),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
