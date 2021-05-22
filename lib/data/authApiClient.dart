import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:remood/data/databaseApiClient.dart';
import 'package:remood/locator.dart';
import 'package:remood/models/users.dart';

class AuthApiClient {
  Future<Users?> loginWithGoogle() async {
    DatabaseApiClient _dbApiClient = getIt<DatabaseApiClient>();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint("google id" + userCredential.user!.uid);

      if (userCredential.additionalUserInfo!.isNewUser) {
        _dbApiClient.saveUser(Users(
            name: "Jane Doe",
            department: "IT",
            moodcoin: 0,
            photoUrl: "",
            email: userCredential.user!.email,
            uid: userCredential.user!.uid));
        debugPrint("yeni");
        return Users(
            email: userCredential.user!.email, uid: userCredential.user!.uid);
      } else {
        debugPrint("Yeni değil");

        return await _dbApiClient.getUser(userCredential.user!.uid);
      }
    } else {
      return null;
    }
  }
}
