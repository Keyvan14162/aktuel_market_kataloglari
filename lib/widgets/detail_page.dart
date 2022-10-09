import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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
  late PageController _pageController;
  int _current = 0;

  @override
  void initState() {
    _current = widget.clickedIndex;
    _pageController = PageController(initialPage: _current);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

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
        body: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity == null) {
              return;
            }
            if (details.primaryVelocity! < 0) {
              // up
              Navigator.of(context).pop(_current);
            }
            if (details.primaryVelocity! > 0) {
              // down
              Navigator.of(context).pop(_current);
            }
          },
          child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider:
                    CachedNetworkImageProvider(widget.imageUrls[index]),
                heroAttributes:
                    PhotoViewHeroAttributes(tag: widget.imageUrls[index]),
              );
            },
            itemCount: widget.imageUrls.length,
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            pageController: _pageController,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
