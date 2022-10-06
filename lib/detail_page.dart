import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({required this.imageUrl, super.key});
  final String imageUrl;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: Hero(
        tag: widget.imageUrl,
        child: Center(
          child: PhotoView(
            imageProvider: CachedNetworkImageProvider(widget.imageUrl),
          ),
        ),
      ),
    );
  }
}
