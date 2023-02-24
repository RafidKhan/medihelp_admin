import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/base/base_state.dart';
import 'package:medihelp_admin/components/app_bar_widget.dart';
import 'package:medihelp_admin/components/common_button.dart';
import 'package:medihelp_admin/components/default_scaffold.dart';
import 'package:medihelp_admin/models/medicine_model.dart';
import 'package:medihelp_admin/modules/add_medicine/controller/add_medicine_controller.dart';
import 'package:medihelp_admin/modules/add_medicine/view/medicine_description.dart';
import 'package:medihelp_admin/modules/add_medicine/view/medicine_image.dart';
import 'package:medihelp_admin/modules/add_medicine/view/medicine_name.dart';
import 'package:medihelp_admin/modules/add_medicine/view/medicine_price.dart';
import 'package:medihelp_admin/modules/add_medicine/view/select_category.dart';
import 'package:medihelp_admin/utils/common_methods.dart';
import 'package:medihelp_admin/utils/styles.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends BaseState<AddMedicine> {
  final addMedicineController = Get.put(AddMedicineController());

  @override
  void initState() {
    // TODO: implement initState
    addMedicineController.fetchCategories();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    addMedicineController.medicineModel = MedicineModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMedicineController>(builder: (controller) {
      return DefaultScaffold(
        appBar: const AppbarWidget(
          title: "Add Medicine",
          hideBackButton: true,
        ),
        body: SingleChildScrollView(
          physics: bouncingPhysics,
          child: Column(
            children: [
              const SelectCategory(),
              const MedicineName(),
              const MedicineDescription(),
              const MedicinePrice(),
              const MedicineImage(),
              CommonButton(
                btnText: "Add Medicine",
                isEnabled: controller.buttonStatus(),
                //isEnabled: true,
                margin: const EdgeInsets.symmetric(
                  horizontal: horizontalMargin,
                  vertical: float10,
                ),
                onTap: () {
                  closeSoftKeyBoard();
                  controller.addMedicine();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
