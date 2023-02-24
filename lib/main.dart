import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/modules/splash/view/splash_screen.dart';
import 'package:medihelp_admin/utils/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MediHelpAdmin());
}

class MediHelpAdmin extends StatelessWidget {
  const MediHelpAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      title: 'MediHelp',
      home: const SplashScreen(),
    );
  }
}
