import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/components/text_field_component.dart';
import 'package:medihelp_admin/modules/add_medicine/controller/add_medicine_controller.dart';
import 'package:medihelp_admin/utils/styles.dart';

class MedicinePrice extends StatelessWidget {
  const MedicinePrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMedicineController>(builder: (controller) {
      return TextFieldComponent(
        hintText: "Price",
        keyboardType: TextInputType.number,
        margin: const EdgeInsets.symmetric(
          horizontal: horizontalMargin,
          vertical: float12,
        ),
        validator: (value) {
          if (value != null) {
            if (value.trim().isEmpty) {
              return "Price is required";
            }
            if (value.trim().isNum && value.trim().startsWith("0")) {
              return "Please enter a valid price";
            }
          }

          return null;
        },
        onChanged: (value) {
          controller.medicineModel.price = value;
          controller.update();
        },
      );
    });
  }
}
