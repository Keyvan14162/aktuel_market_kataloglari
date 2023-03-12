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
      {required this.brochureDateText, required this.color, super.key});
  final String brochureDateText;
  final Color color;

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  late TextEditingController _textController;
  late FirebaseAuth auth;
  bool isSigned = false;
  double borderRadius = 8;

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
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
        child: ExpansionPanelList.radio(
          elevation: 0,
          children: [
            ExpansionPanelRadio(
              backgroundColor: Colors.transparent,
              value: widget.brochureDateText,
              headerBuilder: (context, isExpanded) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      borderRadius,
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
                            Container(
                              width: width - 16,
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
                                  contentPadding: const EdgeInsets.all(8),
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
                              const FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text("Yorum Yapmak İçin Giriş Yapınız"),
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

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: StreamBuilder(
                      stream: CommentFunctions()
                          .getComments(widget.brochureDateText),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          QuerySnapshot<Map<String, dynamic>> data = (snapshot
                              .data as QuerySnapshot<Map<String, dynamic>>);
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
                  ),
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
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            comment,
            style: TextStyle(color: Colors.grey.shade800),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(4.0),
          child: Divider(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
