import 'dart:io';
import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart';
import 'package:aktuel_urunler_bim_a101_sok/providers/is_old_change_notifier.dart';
import 'package:aktuel_urunler_bim_a101_sok/widgets/zoom_drawer/zoom_drawer_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ZoomDrawerMenuScreen extends StatefulWidget {
  const ZoomDrawerMenuScreen(
      {required this.setIndex, required this.currentIndex, super.key});
  final ValueSetter setIndex;
  final int currentIndex;

  @override
  State<ZoomDrawerMenuScreen> createState() => _ZoomDrawerMenuScreenState();
}

class _ZoomDrawerMenuScreenState extends State<ZoomDrawerMenuScreen> {
  @override
  Widget build(BuildContext context) {
    bool isOld = Provider.of<IsOldNotifier>(context, listen: false).isOld;

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
                        const SizedBox(
                          height: 20,
                        ),
                        // google signin
                        const ZoomDrawerProfile(),

                        // menu items
                        Column(
                          children: [
                            Container(
                              color: widget.currentIndex ==
                                      Constants.marketCatagoryCode
                                  ? Colors.grey.withOpacity(0.2)
                                  : Colors.transparent,
                              child: drawerMenuItem(
                                Icons.shopping_cart,
                                Colors.white,
                                "Aktüel Marketler",
                                () {
                                  widget.setIndex(Constants.marketCatagoryCode);
                                },
                              ),
                            ),

                            // eski arayuz kullanilmiyosa bu secenege gerek yok
                            isOld
                                ? Container(
                                    color: widget.currentIndex ==
                                            Constants.textileCatagoryCode
                                        ? Colors.grey.withOpacity(0.2)
                                        : Colors.transparent,
                                    child: drawerMenuItem(
                                      Icons.shopping_bag,
                                      Colors.white,
                                      "Giyim Marketleri",
                                      () {
                                        widget.setIndex(
                                            Constants.textileCatagoryCode);
                                      },
                                    ),
                                  )
                                : const SizedBox.shrink(),

                            drawerMenuItem(
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
                            drawerMenuItem(
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
                            drawerMenuItem(
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

                            isOld
                                ? drawerMenuItem(
                                    Icons.change_circle_rounded,
                                    Colors.white,
                                    "Yeni Arayüzü Kullan",
                                    () async {
                                      context
                                          .read<IsOldNotifier>()
                                          .changeIsOld(isOld: false);

                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool(Constants.isOldKey, false);
                                    },
                                  )
                                : drawerMenuItem(
                                    Icons.change_circle_rounded,
                                    Colors.white,
                                    "Eski Arayüzü Kullan",
                                    () async {
                                      context
                                          .read<IsOldNotifier>()
                                          .changeIsOld(isOld: true);
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool(Constants.isOldKey, true);
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
                            bottomLinkeText("Instagram",
                                "https://www.instagram.com/ismail_kyvsn/"),
                            const Text(" "),
                            bottomLinkeText("Linkedin",
                                "https://www.linkedin.com/in/ismail-keyvan/"),
                            const Text(" "),
                            bottomLinkeText(
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
    );
  }

  Widget drawerMenuItem(
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
                padding: const EdgeInsets.fromLTRB(
                  Constants.defaultPadding,
                  Constants.defaultPadding,
                  2,
                  Constants.defaultPadding,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    2,
                    Constants.defaultPadding,
                    Constants.defaultPadding,
                    Constants.defaultPadding,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          customDivider(),
        ],
      ),
    );
  }

  Container customDivider() {
    return Container(
      width: 0.5.sw,
      height: 1,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(Constants.defaultBorderRadius),
        ),
      ),
    );
  }

  Widget bottomLinkeText(String text, String url) {
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
