import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medihelp_admin/components/loader_widget.dart';
import 'package:medihelp_admin/models/admin_model.dart';
import 'package:medihelp_admin/modules/authentication/login/view/login_view.dart';
import 'package:medihelp_admin/utils/firebase_constants.dart';
import 'package:medihelp_admin/utils/shared_preference.dart';
import 'package:medihelp_admin/utils/styles.dart';
import 'package:permission_handler/permission_handler.dart';

void closeSoftKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

final ImagePicker _picker = ImagePicker();

Future<String> cameraOrGalleryImage(bool isGallery) async {
  String path = "";
  try {
    late ImageSource imageSource;

    if (isGallery) {
      imageSource = ImageSource.gallery;
    } else {
      imageSource = ImageSource.camera;
    }

    if (isGallery) {
      if (await Permission.storage.request().isGranted) {
        final captureFile = await _picker.pickImage(source: imageSource);

        path = captureFile?.path ?? "";
      }
    } else {
      if (await Permission.camera.request().isGranted) {
        final captureFile = await _picker.pickImage(source: imageSource);

        path = captureFile?.path ?? "";
      }
    }
  } catch (e) {
    path = "";
    snackBarWidget(title: "Something went wrong", subTitle: "");
  }

  return path;
}

// Future<String> getUserProfileImageUrl({required userId}) async {
//   var url = "";
//
//   try {
//     var ref = FirebaseStorage.instance
//         .ref()
//         .child("${StoragePath.USER_PROFILE_IMAGE_PATH}${userId}.jpg");
//
//     url = (await ref.getDownloadURL()).toString();
//   } catch (e) {
//     url = "";
//   }
//   return url;
// }

snackBarWidget(
    {required String title, required String subTitle, Color? color}) {
  Get.snackbar(
    title,
    subTitle,
    backgroundColor: color ?? Colors.white,
  );
}

int multiplyStrings(List<String> strings) {
  int result = 1;
  for (int i = 0; i < strings.length; i++) {
    final convertToInt = int.parse(strings[i]);
    result = result * convertToInt;
  }

  return result;
}

showLoaderAlert() {
  Get.dialog(AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LoaderWidget(),
      ],
    ),
  ));
}

logoutUser() async {
  showLoaderAlert();
  await FirebaseAuth.instance.signOut();
  await SharedPref.removeAll();
  Get.back();
  Get.off(
    () => const LoginView(),
    transition: defaultPageTransition,
  );
}

// Future<UserModel?> getUserData(String userId) async {
//   UserModel? userModel;
//
//   await FirebaseFirestore.instance
//       .collection(TableUsers.collectionName)
//       .doc(userId)
//       .get()
//       .then((value) {
//     if (value.data() != null) {
//       userModel = UserModel.fromJson(value.data()!);
//     }
//   });
//
//   return userModel;
// }

Future<AdminModel?> getAdminData(String adminId) async {
  AdminModel? userModel;

  await FirebaseFirestore.instance
      .collection(TableAdmins.collectionName)
      .doc(adminId)
      .get()
      .then((value) {
    if (value.data() != null) {
      userModel = AdminModel.fromJson(value.data()!);
    }
  });

  return userModel;
}
