import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sillog/home/screens/login_google.dart';

class UserController extends GetxController {
  String jwt = '';
  String id = '';
  String name = '';
  String email = '';
  String photo = '';

  String oauthProvider = '';

  Future<void> login(String oauth) async {
    oauthProvider = oauth;
    switch (oauth) {
      case 'google':
        await GoogleSignInController.googleLogin();
    }
  }

  Future<void> logout() async {
    switch (oauthProvider) {
      case 'google':
        GoogleSignInController.googleLogout();
        await FirebaseAuth.instance.signOut();
        break;
      default:
        return;
    }
  }
}

class GoogleSignInController {
  static Future<UserCredential> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      // if (googleUser == null) return;
      // _user = googleUser;

      final googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw e;
    }
  }

  static Future googleLogout() async {
    try {
      await GoogleSignIn().disconnect();
      FirebaseAuth.instance.signOut();
    } catch (e) {
      throw e;
    }
  }
}
