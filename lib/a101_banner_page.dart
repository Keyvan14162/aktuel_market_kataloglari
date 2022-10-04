import 'package:aktuel_urunler_bim_a101_sok/helpers/a101.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_view/photo_view.dart';

class A101BannerPage extends StatefulWidget {
  const A101BannerPage({required this.categoryUrl, super.key});
  final String categoryUrl;

  @override
  State<A101BannerPage> createState() => _A101BannerPageState();
}

class _A101BannerPageState extends State<A101BannerPage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryUrl.split("/")[3].replaceAll("-", " ").toUpperCase(),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: A101().getBrochurePageImageUrls(widget.categoryUrl),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String> brochurePages = snapshot.data as List<String>;

              return Column(
                children: [
                  // img
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final double height =
                            MediaQuery.of(context).size.height;
                        return CarouselSlider(
                          carouselController: _controller,
                          options: CarouselOptions(
                            height: height,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            enableInfiniteScroll: false,
                            // autoPlay: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            },
                          ),
                          items: brochurePages
                              .map(
                                (url) => Center(
                                    child: PhotoView(
                                  imageProvider: NetworkImage(url),
                                  backgroundDecoration:
                                      const BoxDecoration(color: Colors.white),
                                )
                                    /*
                                  Image.network(
                                    item,
                                    fit: BoxFit.cover,
                                    height: height,
                                  ),
                                */
                                    ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ),
                  // durum indikatoru
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: brochurePages.asMap().entries.map((entry) {
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
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.blue)
                                .withOpacity(_current == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                    // color
                    ),
              );
            }
          },
        ),
      ),
    );
  }
}
