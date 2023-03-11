import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Deneme extends StatefulWidget {
  const Deneme({super.key});

  @override
  State<Deneme> createState() => _DenemeState();
}

class _DenemeState extends State<Deneme> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late FirebaseAuth auth;
  bool isSigned = false;
  @override
  void initState() {
    auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) {
      // giris yaptıyda yolla uygulama sayfasına
      // yoksa burdan giris yapsın

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
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: Text("Google"),
              onPressed: () async {
                UserCredential userCredential = await googleSignInn();
              },
            ),
            MaterialButton(
              child: Text("Sign Out"),
              onPressed: () {
                auth.signOut();
              },
            ),
            isSigned ? Text("signed") : Text("not signed"),
          ],
        ),
      ),
    );
  }

  Future<UserCredential> googleSignInn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
