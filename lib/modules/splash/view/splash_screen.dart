import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/components/default_scaffold.dart';
import 'package:medihelp_admin/gen/assets.gen.dart';
import 'package:medihelp_admin/modules/authentication/login/view/login_view.dart';
import 'package:medihelp_admin/modules/bottom_nav_page/view/bottom_nav_page.dart';
import 'package:medihelp_admin/utils/shared_preference.dart';
import 'package:medihelp_admin/utils/shared_preference_keys.dart';
import 'package:medihelp_admin/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    checkUserStatus();
    super.initState();
  }

  Future<void> checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final isLoggedIn = await SharedPref.read(prefKeyLoginStatus);
    if (isLoggedIn != null) {
      Get.off(() => const BottomNavScreen(), transition: defaultPageTransition);
    } else {
      Get.off(() => const LoginView(), transition: defaultPageTransition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Image.asset(
            Assets.logo.appLogo.path,
            height: 100,
            width: 100,
          ),
        ));
  }
}
