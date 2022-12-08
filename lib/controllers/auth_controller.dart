import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/main.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/socialchart/socialchart_controller.dart';
// FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  var errorString = "".obs;
  var isNewUser = false.obs;
  var userEmail = "".obs;

  late Rxn<User?> firebaseUser = Rxn<User?>(firebaseAuth.currentUser);

  final _currentUser = Rxn<ModelUserData>();

  ModelUserData? get currentUser => _currentUser.value;

  // @override
  // void onInit() {}

  @override
  void onInit() {
    super.onReady();
    // firebaseUser = Rxn<User?>(auth.currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());

    ever(firebaseUser, (_) async {
      if (_ != null) {
        userDataColRef().doc(_.uid).get().then(
              (value) => _currentUser.value = value.data(),
            );
      }
    });
  }

  Future<UserCredential?> loginWithEmailAndPassword(
      String email, password) async {
    try {
      return await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((error) => errorString.value = error.message);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    var loading = SocialChartController.to;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        loading.showFullScreenLoadingIndicator = true;
        return await firebaseAuth
            .signInWithCredential(credential)
            .then((value) {
          loading.showFullScreenLoadingIndicator = false;
          return value;
        });
      } else {
        loading.showFullScreenLoadingIndicator = false;
        return null;
      }
    } catch (error) {
      loading.showFullScreenLoadingIndicator = false;
      rethrow;
    }
  }

  Future<UserCredential?> signInWithApple() async {
    var loading = SocialChartController.to;
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      loading.showFullScreenLoadingIndicator = true;
      return await firebaseAuth.signInWithCredential(oauthCredential).then(
        (value) {
          loading.showFullScreenLoadingIndicator = false;
          return value;
        },
      );
    } catch (error) {
      loading.showFullScreenLoadingIndicator = false;
      rethrow;
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, password) async {
    UserCredential userCredential;
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  void signOut() async {
    NavigatorMainController.to.currentIndex = NavKeys.home;
    await firebaseAuth.signOut();
    Get.snackbar("로그아웃", "로그아웃되었습니다.");
  }

  Future<bool> sendPasswordReset(String email) async {
    return await firebaseAuth
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
      return await firebaseAuth.sendSignInLinkToEmail(
          email: email, actionCodeSettings: acs);
    } catch (e) {
      rethrow;
    }
  }
}
