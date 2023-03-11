import 'package:aktuel_urunler_bim_a101_sok/firebase/sign_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ZoomDrawerProfile extends StatefulWidget {
  const ZoomDrawerProfile({super.key});

  @override
  State<ZoomDrawerProfile> createState() => _ZoomDrawerProfileState();
}

class _ZoomDrawerProfileState extends State<ZoomDrawerProfile> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late FirebaseAuth auth;
  bool isSigned = false;
  @override
  void initState() {
    auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print(" -------- User is currently signed out.");
        isSigned = false;
        setState(() {});
      } else {
        print(" -------- User signed in ${user.email} - ${user.emailVerified}");
        isSigned = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isSigned
        ? Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  backgroundImage: CachedNetworkImageProvider(
                    auth.currentUser?.photoURL.toString() ?? "",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                " ${auth.currentUser?.displayName ?? "Kullanıcı"}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                " ${auth.currentUser?.email ?? "Kullanıcı"}",
                style: const TextStyle(color: Colors.white),
              ),
              SignInButton(
                Buttons.Google,
                text: "Çıkış Yap",
                onPressed: () async {
                  await auth.signOut();
                },
              )
            ],
          )
        : Column(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 60,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              SignInButton(
                Buttons.Google,
                text: "Google ile Giriş Yap",
                onPressed: () async {
                  UserCredential userCredential = await googleSign();
                },
              )
            ],
          );
  }
}
