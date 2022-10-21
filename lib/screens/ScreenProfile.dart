import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:socialchart/navigators/BottomTabNavigator.dart';
import 'package:socialchart/navigators/NavigationTree.dart';
import 'package:timeago/timeago.dart' as timeago;

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email Address: ${auth.currentUser!.email.toString()}'),
            Text('Displayed Name: ${auth.currentUser!.displayName.toString()}'),
            Text('Photo URL: ${auth.currentUser!.photoURL.toString()}'),
            Text('UID: ${auth.currentUser!.uid.toString()}'),
            Text('TenantId: ${auth.currentUser!.tenantId.toString()}'),
            Text(timeago.format(auth.currentUser!.metadata.lastSignInTime!)),
            Text('lastSignIn: ${auth.currentUser!.metadata.lastSignInTime}'),
            Text(
                "Email Verification: ${auth.currentUser!.emailVerified ? "Verified" : "Not verified"}"),
            OutlinedButton(
              child: Text("Sign Out"),
              onPressed: () {
                IndexController.to.changeTabIndex(TabItem.home);
                AuthController.to.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
