import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  var errorString = "".obs;
  var isNewUser = false.obs;
  late Rx<User?> firebaseUser;

  @override
  void onInit() {}

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
  }

  Future<UserCredential?> loginWithEmailAndPassword(
      String email, password) async {
    return await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) => errorString = error.message);
  }

  Future<UserCredential?> googleAuthSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      print("google user!");
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await auth.signInWithCredential(credential);
    } else {
      print("error");
    }
  }

  Future<UserCredential?> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email],
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
    return await auth.signInWithCredential(oauthCredential);
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, password) async {
    UserCredential userCredential;
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      throw (error);
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}
