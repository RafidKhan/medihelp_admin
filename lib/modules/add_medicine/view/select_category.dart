import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/components/bottom_sheet_component.dart';
import 'package:medihelp_admin/components/selectable_textfield.dart';
import 'package:medihelp_admin/components/text_component.dart';
import 'package:medihelp_admin/modules/add_medicine/controller/add_medicine_controller.dart';
import 'package:medihelp_admin/utils/styles.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMedicineController>(builder: (controller) {
      return SelectableTextField(
        text: controller.medicineModel.category,
        padding: const EdgeInsets.symmetric(
          horizontal: float5,
          vertical: float16,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: horizontalMargin,
          vertical: float12,
        ),
        hintText: "Select Category",
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return BottomSheetComponent(
                title: "Select Category",
                listChildren: Expanded(
                  child: ListView.separated(
                      itemCount: controller.listCategories.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var element = controller.listCategories[index];
                        return InkWell(
                          onTap: () {
                            controller.medicineModel.category =
                                element.name ?? "";
                            controller.medicineModel.categoryId =
                                element.id ?? "";
                            Get.back();
                            controller.update();
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: TextComponent(
                              element.name ?? "",
                              textAlign: TextAlign.start,
                              fontSize: fontSize16,
                              padding: const EdgeInsets.symmetric(
                                horizontal: horizontalMargin,
                                vertical: float10,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      }),
                ),
              );
            },
          );
        },
      );
    });
  }
}
