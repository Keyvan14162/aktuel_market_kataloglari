import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class A101BannerPage extends StatefulWidget {
  const A101BannerPage({required this.categoryUrl, super.key});
  final String categoryUrl;

  @override
  State<A101BannerPage> createState() => _A101BannerPageState();
}

class _A101BannerPageState extends State<A101BannerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.categoryUrl),
    );
  }
}
