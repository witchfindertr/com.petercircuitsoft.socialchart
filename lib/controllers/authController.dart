import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:socialchart/controllers/isLoadingController.dart';

FirebaseAuth auth = FirebaseAuth.instance;
// FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  var errorString = "".obs;
  var isNewUser = false.obs;
  var userEmail = "".obs;

  late Rxn<User?> firebaseUser = Rxn<User?>(auth.currentUser);

  // @override
  // void onInit() {}

  @override
  void onInit() {
    super.onReady();
    // firebaseUser = Rxn<User?>(auth.currentUser);
    ever(firebaseUser, (_) => {});
    firebaseUser.bindStream(auth.userChanges());
  }

  Future<UserCredential?> loginWithEmailAndPassword(
      String email, password) async {
    try {
      return await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((error) => errorString.value = error.message);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        IsLoadingController.to.isLoading = true;
        return await auth.signInWithCredential(credential).then((value) {
          IsLoadingController.to.isLoading = false;
          return value;
        });
      } else {
        IsLoadingController.to.isLoading = false;
        return null;
      }
    } catch (error) {
      IsLoadingController.to.isLoading = false;
      rethrow;
    }
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      IsLoadingController.to.isLoading = true;
      return await auth.signInWithCredential(oauthCredential).then(
        (value) {
          IsLoadingController.to.isLoading = false;
          return value;
        },
      );
    } catch (error) {
      IsLoadingController.to.isLoading = false;
      rethrow;
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, password) async {
    UserCredential userCredential;
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  void signOut() async {
    await auth.signOut();
  }

  Future<bool> sendPasswordReset(String email) async {
    return await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then(((value) => true))
        .catchError((onError) => false);
  }

  Future<void> sendCreateAccountLink(String email) async {
    var acs = ActionCodeSettings(
        // dynamicLinkDomain: "https://socialchartapp.page.link/",
        url: "https://socialchartapp.page.link/VXX6",
        handleCodeInApp: true,
        iOSBundleId: 'com.petercircuitsoft.socialchart',
        androidPackageName: 'com.petercircuitsoft.socialchart',
        androidInstallApp: true,
        androidMinimumVersion: '12');
    userEmail.value = email;
    try {
      return await auth.sendSignInLinkToEmail(
          email: email, actionCodeSettings: acs);
    } catch (e) {
      rethrow;
    }
  }
}
