import 'package:aktuel_urunler_bim_a101_sok/helpers/sok.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants.dart' as constants;

class SokGridView extends StatefulWidget {
  const SokGridView({required this.pageUrl, required this.title, super.key});
  final String pageUrl;
  final String title;

  @override
  State<SokGridView> createState() => _SokGridViewState();
}

class _SokGridViewState extends State<SokGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
      ),
      body: Container(
        color: constants.sokColor.withOpacity(0.1),
        child: FutureBuilder(
          future: Sok().getSokBrochurePageImgUrls(widget.pageUrl),
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
                          constants.sokColor,
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
