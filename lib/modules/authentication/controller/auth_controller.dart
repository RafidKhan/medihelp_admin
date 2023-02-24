import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/modules/bottom_nav_page/view/bottom_nav_page.dart';
import 'package:medihelp_admin/utils/firebase_constants.dart';
import 'package:medihelp_admin/utils/shared_preference.dart';
import 'package:medihelp_admin/utils/shared_preference_keys.dart';
import 'package:medihelp_admin/utils/styles.dart';

import '../../../utils/common_methods.dart';

class AuthController extends GetxController {
  final loginPhoneNumber = Rxn<String?>();
  final otpValue = Rxn<String?>();

  RxBool verifyButtonLoading = false.obs;

  String verificationIDPhoneSignIn = "";

  Future<void> getLoginOtp() async {
    final phoneNumber = "${loginPhoneNumber.value}";
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        snackBarWidget(
            title: "Something went wrong", subTitle: e.message ?? "");
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationIDPhoneSignIn = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationIDPhoneSignIn = verificationId;
      },
      timeout: const Duration(seconds: 120),
    );
  }

  Future<void> verifyPhoneLogin() async {
    try {
      verifyButtonLoading.value = true;
      await FirebaseAuth.instance
          .signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationIDPhoneSignIn,
            smsCode: otpValue.value ?? ""),
      )
          .then((value) async {
        if (value.user != null) {
          var userId = value.user?.uid;

          await FirebaseFirestore.instance
              .collection(TableAdmins.collectionName)
              .doc(userId)
              .get()
              .then((value) async {
            await SharedPref.write(prefKeyLoginStatus, "true");
            await SharedPref.write(prefKeyUserId, userId);
            verifyButtonLoading.value = false;
            Get.off(() => const BottomNavScreen(),
                transition: defaultPageTransition);
            // if (value.data() == null) {
            //   verifyButtonLoading.value = false;
            //   snackBarWidget(
            //       title: "Registration Required",
            //       subTitle:
            //           "You must register first, before you could use your phone number for sign in");
            // } else {
            //   await SharedPref.write(prefKeyLoginStatus, "true");
            //   await SharedPref.write(prefKeyUserId, userId);
            //   verifyButtonLoading.value = false;
            //   Get.off(() => const BottomNavScreen(),
            //       transition: defaultPageTransition);
            // }
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      verifyButtonLoading.value = false;
      snackBarWidget(title: "Something went wrong", subTitle: e.message ?? "");
    } catch (e) {
      verifyButtonLoading.value = false;
      snackBarWidget(title: "Something went wrong", subTitle: "");
    }
  }
}
