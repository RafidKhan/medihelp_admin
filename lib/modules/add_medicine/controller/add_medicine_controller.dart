import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/models/category_model.dart';
import 'package:medihelp_admin/models/medicine_model.dart';
import 'package:medihelp_admin/utils/common_methods.dart';
import 'package:medihelp_admin/utils/firebase_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddMedicineController extends GetxController {
  MedicineModel medicineModel = MedicineModel();
  String medicineImagePath = "";

  List<CategoryModel> listCategories = <CategoryModel>[];

  Future<void> fetchCategories() async {
    listCategories = [];
    try {
      await FirebaseFirestore.instance
          .collection(TableCategory.collectionName)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          listCategories.add(CategoryModel.fromJson(value.docs[i].data()));
        }
      });
      update();
    } catch (e) {
      snackBarWidget(title: "Error Loading Categories", subTitle: "");
    }
  }

  Future<void> addMedicine() async {
    try {
      showLoaderAlert();
      final medicineId = FirebaseFirestore.instance
          .collection(TableMedicines.collectionName)
          .doc()
          .id;

      File medicineImageFile = File(medicineImagePath);
      await FirebaseStorage.instance
          .ref()
          .child("${StoragePath.MEDICINE_IMAGE}${medicineId}.jpg")
          .putFile(medicineImageFile);
      medicineModel.id = medicineId;
      medicineModel.image = await getMedicineImageUrl(medicineId: medicineId);

      await FirebaseFirestore.instance
          .collection(TableMedicines.collectionName)
          .doc(medicineId)
          .set(medicineModel.toJson());

      medicineModel = MedicineModel();
      medicineImagePath = "";
      update();
      Get.back();
      snackBarWidget(title: "Medicine has been addded", subTitle: "");
    } catch (e) {
      Get.back();
      snackBarWidget(title: "Something went wrong", subTitle: "");
    }
  }

  bool buttonStatus() {
    if (medicineImagePath.trim().isNotEmpty &&
        medicineModel.categoryId != null &&
        medicineModel.name != null &&
        medicineModel.category != null &&
        medicineModel.price != null &&
        medicineModel.description != null) {
      if (medicineModel.price!.isNum && !medicineModel.price!.startsWith("0")) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
