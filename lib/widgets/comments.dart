import 'package:aktuel_urunler_bim_a101_sok/constants/constants.dart';
import 'package:aktuel_urunler_bim_a101_sok/firebase/comment_functions.dart';
import 'package:aktuel_urunler_bim_a101_sok/firebase/sign_functions.dart';
import 'package:aktuel_urunler_bim_a101_sok/helpers/top_snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class Comments extends StatefulWidget {
  const Comments(
      {required this.scrollDown,
      required this.brochureDateText,
      required this.color,
      super.key});
  final VoidCallback scrollDown;
  final String brochureDateText;
  final Color color;

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  late TextEditingController _textController;
  late FirebaseAuth auth;
  bool isSigned = false;

  @override
  void initState() {
    _textController = TextEditingController();
    auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) {
      try {
        if (user == null) {
          setState(() {
            isSigned = false;
          });
        } else {
          setState(() {
            isSigned = true;
          });
        }
      } catch (e) {
        debugPrint("COMMENTS ERROR - $e");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        Constants.defaultBorderRadius,
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(Constants.defaultBorderRadius),
          ),
        ),
        child: ExpansionPanelList.radio(
          elevation: 0,
          expansionCallback: (panelIndex, isExpanded) {
            widget.scrollDown();
          },
          children: [
            ExpansionPanelRadio(
              backgroundColor: Colors.transparent,
              value: widget.brochureDateText,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Constants.defaultBorderRadius),
                    ),
                    color: widget.color.withOpacity(0.8),
                  ),
                  child: const Center(
                    child: Text(
                      "Yorumlar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                );
              },
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // text field
                  isSigned
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: _textController,
                                  textAlignVertical: TextAlignVertical.center,
                                  enableInteractiveSelection: true,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: "Yorum Ekleyin",
                                    contentPadding: const EdgeInsets.all(
                                        Constants.defaultPadding),
                                    // border: InputBorder.none,
                                    suffixIcon: MaterialButton(
                                      child: const Text("Yorumu Gönder"),
                                      //color: widget.color,
                                      onPressed: () {
                                        if (_textController.text != "") {
                                          CommentFunctions().addComment(
                                            auth.currentUser?.displayName ??
                                                "Kullanici",
                                            _textController.text,
                                            auth.currentUser?.photoURL ?? "",
                                            widget.brochureDateText,
                                          );
                                          _textController.text = "";
                                          TopSnackbar().showSnackbar(
                                            context,
                                            const CustomSnackBar.success(
                                                message: "Yorumunuz Eklendi"),
                                          );
                                        } else {
                                          TopSnackbar().showSnackbar(
                                            context,
                                            const CustomSnackBar.error(
                                                message:
                                                    "Lütfen Yorum Metini Giriniz"),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : MaterialButton(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'http://pngimg.com/uploads/google/google_PNG19635.png',
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              ),
                              const Flexible(
                                child: Center(
                                  child: Text(
                                    "Yorum Yapmak ve Yorumları Görmek İçin Giriş Yapınız",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                          onPressed: () async {
                            UserCredential userCredential = await googleSign();
                            // ignore: use_build_context_synchronously
                            TopSnackbar().showSnackbar(
                              context,
                              CustomSnackBar.success(
                                  message:
                                      "${userCredential.user?.displayName ?? ""} Giriş Yapıldı"),
                            );
                          },
                        ),
                  const SizedBox(
                    height: 10,
                  ),

                  isSigned
                      ? Padding(
                          padding:
                              const EdgeInsets.all(Constants.defaultPadding),
                          child: StreamBuilder(
                            stream: CommentFunctions()
                                .getComments(widget.brochureDateText),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                QuerySnapshot<Map<String, dynamic>> data =
                                    (snapshot.data
                                        as QuerySnapshot<Map<String, dynamic>>);
                                return Column(
                                  children: [
                                    for (var element in data.docs)
                                      commentItem(
                                        element.data()["userName"],
                                        element.data()["commentText"],
                                        element.data()["date"],
                                        element.data()["profilePicUrl"],
                                      ),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Her broşür için 1 adet yorum yapabilirsiniz. Aynı broşüre yeni bir yorum eklediğinizde eski yorumunuzun üzerine yazılacaktır.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column commentItem(
      String name, String comment, Timestamp timestamp, String profilePicUrl) {
    DateTime dateTime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    var day = dateTime.day;
    var month = dateTime.month;
    var year = dateTime.year;
    var hour = dateTime.hour;
    var minute = dateTime.minute;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              backgroundImage: CachedNetworkImageProvider(
                profilePicUrl,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "$day/$month/$year - $hour:$minute",
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: Constants.defaultPadding),
          child: SelectableText(
            comment,
            style: TextStyle(color: Colors.grey.shade800),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(Constants.defaultPadding / 2),
          child: Divider(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
