import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/components/adatptive_button.dart';
import 'package:medihelp_admin/components/text_component.dart';
import 'package:medihelp_admin/gen/assets.gen.dart';
import 'package:medihelp_admin/modules/add_medicine/controller/add_medicine_controller.dart';
import 'package:medihelp_admin/utils/common_methods.dart';
import 'package:medihelp_admin/utils/styles.dart';

class MedicineImage extends StatelessWidget {
  const MedicineImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMedicineController>(builder: (controller) {
      return Column(
        children: [
          controller.medicineImagePath.trim().isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: FadeInImage(
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    placeholder: AssetImage(Assets.images.transparentBg.path),
                    image: FileImage(
                      File(controller.medicineImagePath),
                    ),
                  ),
                )
              : const SizedBox(),
          InkWell(
            onTap: () async {
              closeSoftKeyBoard();
              final bool? isGallery = await Get.dialog(AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextComponent(
                      "Select one",
                      fontSize: fontSize16,
                      fontWeight: fontWeight400,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalMargin,
                        vertical: float10,
                      ),
                    ),
                    AdaptiveButton(
                        btnText: 'Gallery',
                        onTap: () {
                          Get.back(result: true);
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    AdaptiveButton(
                        btnText: 'Camera',
                        onTap: () {
                          Get.back(result: false);
                        }),
                  ],
                ),
              ));
              if (isGallery != null) {
                final String path = await cameraOrGalleryImage(isGallery);
                if (path.isNotEmpty) {
                  controller.medicineImagePath = path;
                  controller.update();
                }
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: float12,
                horizontal: horizontalMargin,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: float12,
                horizontal: horizontalMargin,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: kTextFieldBorder,
                ),
              ),
              child: Center(
                child: Column(
                  children: const [
                    Icon(
                      Icons.upload_outlined,
                      color: kFadedTextColor,
                    ),
                    TextComponent(
                      "Select Image",
                      color: kFadedTextColor,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
