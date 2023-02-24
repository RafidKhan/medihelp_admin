import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/models/admin_model.dart';
import 'package:medihelp_admin/utils/common_methods.dart';
import 'package:medihelp_admin/utils/firebase_constants.dart';
import 'package:medihelp_admin/utils/shared_preference.dart';

import '../../../utils/shared_preference_keys.dart';

class ProfileController extends GetxController {
  AdminModel? myProfileData;
  bool loadingLocation = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> getProfileData(context) async {
    final String adminId = await SharedPref.read(prefKeyUserId) ?? "";
    try {
      myProfileData = await getAdminData(adminId);
      update();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
  }) async {
    if (myProfileData != null) {
      showLoaderAlert();
      myProfileData?.name = name;
      myProfileData?.email = email;

      await FirebaseFirestore.instance
          .collection(TableAdmins.collectionName)
          .doc(myProfileData?.userId)
          .update(myProfileData!.toJson());
    }

    Get.back();
    update();
    snackBarWidget(title: "Profile has been updated", subTitle: "");
  }
}
