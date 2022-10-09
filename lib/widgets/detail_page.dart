import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {required this.imageUrls, required this.clickedIndex, super.key});
  final List<String> imageUrls;
  final int clickedIndex;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  @override
  void initState() {
    _current = widget.clickedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _current = widget.clickedIndex;
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(_current);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(_current);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          elevation: 0,
        ),
        body: CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            initialPage: widget.clickedIndex,
            height: MediaQuery.of(context).size.height,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              _current = index;
            },
          ),
          items: widget.imageUrls
              .map(
                (imageUrl) => Hero(
                  tag: imageUrl,
                  child: GestureDetector(
                    child: Center(
                      child: PhotoView(
                        imageProvider: CachedNetworkImageProvider(imageUrl),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        /* 
        Hero(
          tag: widget.imageUrl,
          child: GestureDetector(
            onHorizontalDragStart: (details) {},
            child: Center(
              child: PhotoView(
                imageProvider: CachedNetworkImageProvider(widget.imageUrl),
              ),
            ),
          ),
        ),
        */
      ),
    );
  }
}
