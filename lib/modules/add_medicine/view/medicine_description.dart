import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/components/text_field_component.dart';
import 'package:medihelp_admin/modules/add_medicine/controller/add_medicine_controller.dart';
import 'package:medihelp_admin/utils/styles.dart';

class MedicineDescription extends StatelessWidget {
  const MedicineDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMedicineController>(builder: (controller) {
      return TextFieldComponent(
        hintText: "Description",
        maxLines: 5,
        maxLength: 100,
        margin: const EdgeInsets.symmetric(
          horizontal: horizontalMargin,
          vertical: float12,
        ),
        onChanged: (value) {
          controller.medicineModel.description = value;
          controller.update();
        },
      );
    });
  }
}
