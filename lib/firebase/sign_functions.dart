import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignFunctions {}

Future<UserCredential> googleSign() async {
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

googleSignOut(GoogleSignIn googleSignIn, FirebaseAuth auth) async {
  final googleCurrentUser =
      GoogleSignIn().currentUser ?? await googleSignIn.signIn();
  if (googleCurrentUser != null) {
    await googleSignIn.disconnect().catchError((e, stack) {
      debugPrint(stack);
      return e;
    });
  }
  await auth.signOut();
}
