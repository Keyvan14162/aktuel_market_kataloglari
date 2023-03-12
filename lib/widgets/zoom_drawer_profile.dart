import 'package:aktuel_urunler_bim_a101_sok/firebase/sign_functions.dart';
import 'package:aktuel_urunler_bim_a101_sok/helpers/top_snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

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
        isSigned = false;
        setState(() {});
      } else {
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
                height: 8,
              ),
              Text(
                " ${auth.currentUser?.displayName ?? "Kullanıcı"}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                " ${auth.currentUser?.email ?? "kullanici@gmail.com"}",
                style: const TextStyle(color: Colors.white),
              ),
              MaterialButton(
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
                      child: Text("Çıkış Yap"),
                    )
                  ],
                ),
                onPressed: () async {
                  await googleSignOut(_googleSignIn, auth);
                  // ignore: use_build_context_synchronously
                  TopSnackbar().showSnackbar(
                    context,
                    const CustomSnackBar.success(message: "Çıkış Yapıldı"),
                  );
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
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
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
                      child: Text("Google ile Giriş Yap"),
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
              )
            ],
          );
  }
}
