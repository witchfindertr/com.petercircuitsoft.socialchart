import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum NavKeys { home, explore, notice, profile, login, fullscreen }

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseStorage firestorage = FirebaseStorage.instance;
// Map<TabItem, BottomTabs> bottomTabConstant = {
//   TabItem.home: BottomTabs(icon: Icons.home, name: "홈"),
//   TabItem.explore: BottomTabs(icon: Icons.home, name: "탐색"),
//   TabItem.explore: BottomTabs(icon: Icons.home, name: "탐색"),
//   TabItem.explore: BottomTabs(icon: Icons.home, name: "탐색"),
// };
