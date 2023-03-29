import 'dart:io';
import 'package:aktuel_urunler_bim_a101_sok/widgets/zoom_drawer_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:aktuel_urunler_bim_a101_sok/constants/constant_values.dart'
    as constant_values;

class ZoomDrawerMenuScreen extends StatefulWidget {
  ZoomDrawerMenuScreen(
      {required this.setIndex, required this.currentIndex, super.key});
  final ValueSetter setIndex;
  int currentIndex;

  @override
  State<ZoomDrawerMenuScreen> createState() => _ZoomDrawerMenuScreenState();
}

class _ZoomDrawerMenuScreenState extends State<ZoomDrawerMenuScreen> {
  final double dividerContainerHeight = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: p1.maxHeight),
            child: IntrinsicHeight(
              child: Container(
                color: Theme.of(context).primaryColor.withOpacity(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        // title and image
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 28, 8, 40),
                          child: Center(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        ZoomDrawer.of(context)!.toggle();
                                      },
                                      icon: const Icon(
                                        Icons.menu_open,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Flexible(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "Aktüel Market Katalogları",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // google signin
                                const ZoomDrawerProfile(),
                              ],
                            ),
                          ),
                        ),

                        // menu items
                        Column(
                          children: [
                            Container(
                              color: widget.currentIndex ==
                                      constant_values.marketPageCode
                                  ? Colors.grey.withOpacity(0.2)
                                  : Colors.transparent,
                              child: createDrawerMenuItem(
                                Icons.shopping_cart,
                                Colors.white,
                                "Aktüel Marketler",
                                () {
                                  widget
                                      .setIndex(constant_values.marketPageCode);
                                },
                              ),
                            ),
                            Container(
                              color: widget.currentIndex ==
                                      constant_values.textilePageCode
                                  ? Colors.grey.withOpacity(0.2)
                                  : Colors.transparent,
                              child: createDrawerMenuItem(
                                Icons.shopping_bag,
                                Colors.white,
                                "Giyim Marketleri",
                                () {
                                  widget.setIndex(
                                      constant_values.textilePageCode);
                                },
                              ),
                            ),
                            createDrawerMenuItem(
                              Icons.star,
                              Colors.yellow,
                              "Uygulamayı Puanla",
                              () async {
                                if (!await launchUrl(
                                  Uri.parse(
                                      "https://play.google.com/store/apps/details?id=com.ismailkeyvan.aktuel_urunler_bim_a101_sok"),
                                  mode: LaunchMode.externalApplication,
                                )) {
                                  throw "Could not launch ";
                                }
                              },
                            ),
                            createDrawerMenuItem(
                              Icons.email,
                              Theme.of(context).primaryColor,
                              "Market İsteği Bildir",
                              () async {
                                if (!await launchUrl(
                                  Uri.parse(
                                      "mailto:ismailkyvsn2000@gmail.com?subject=Merhaba%20!&body="),
                                  mode: LaunchMode.externalApplication,
                                )) {
                                  throw "Could not launch ";
                                }
                              },
                            ),
                            createDrawerMenuItem(
                              Icons.exit_to_app,
                              Theme.of(context).primaryColor,
                              "Çıkış",
                              () {
                                if (defaultTargetPlatform ==
                                    TargetPlatform.android) {
                                  SystemNavigator.pop();
                                } else {
                                  exit(0);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Bottom Link Part
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // sosyal medya
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            createBottomLinkeText("Instagram",
                                "https://www.instagram.com/ismail_kyvsn/"),
                            const Text(" "),
                            createBottomLinkeText("Linkedin",
                                "https://www.linkedin.com/in/ismail-keyvan/"),
                            const Text(" "),
                            createBottomLinkeText(
                                "Github", "https://github.com/Keyvan14162"),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),

                        // hakkinda
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Center(
                                        child:
                                            Text("Aktüel Market Katalogları"),
                                      ),
                                      content: const Text(
                                        "Bim, A101 ve Şok  ve diğer birçok marketlerin aktüel kataloglarını ve tekstil ürünleri kataloglarını canlı olarak takip edebilmeniz için geliştirilmiş bir uygulamadır. Uygulama kişisel verilerinize erişim izni istemez, kişisel verilerinizi göremez, kullanamaz yada değiştiremez. Uygulamamıza destek vermek için yorum yapmayı ve puanlamayı unutmayınız!\n\n İyi alışverişler dileriz...",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Tamam"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.white.withOpacity(0.6),
                                    size: 14,
                                  ),
                                  Text(
                                    "Hakkında",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 1.6,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      /* */
    );
  }

  Widget createDrawerMenuItem(
      IconData icon, Color iconColor, String text, onPressedFunc) {
    return InkWell(
      onTap: () {
        onPressedFunc();
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 2, 8),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(2, 8, 8, 8),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  Widget createBottomLinkeText(String text, String url) {
    return Flexible(
      child: GestureDetector(
        onTap: () async {
          if (!await launchUrl(Uri.parse(url),
              mode: LaunchMode.externalApplication)) {
            throw "Could not launch ";
          }
        },
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              decoration: TextDecoration.underline,
              decorationThickness: 1.6,
              fontSize: 10,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
