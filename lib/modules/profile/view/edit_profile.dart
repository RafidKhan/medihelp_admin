import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/components/common_button.dart';
import 'package:medihelp_admin/components/text_field_component.dart';
import 'package:medihelp_admin/modules/profile/controller/profile_controller.dart';
import 'package:medihelp_admin/utils/common_methods.dart';
import 'package:medihelp_admin/utils/styles.dart';
import 'package:medihelp_admin/components/app_bar_widget.dart';
import 'package:medihelp_admin/components/default_scaffold.dart';
import 'package:medihelp_admin/components/loader_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.nameController.text =
          profileController.myProfileData!.name?.trim() ?? "";
      profileController.emailController.text =
          profileController.myProfileData!.email?.trim() ?? "";
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return DefaultScaffold(
          appBar: const AppbarWidget(
            title: 'Edit Profile',
          ),
          body: controller.myProfileData == null &&
                  controller.loadingLocation == true
              ? LoaderWidget()
              : SingleChildScrollView(
                  physics: bouncingPhysics,
                  child: Column(
                    children: [
                      TextFieldComponent(
                        controller: profileController.nameController,
                        hintText: "Name",
                        margin: const EdgeInsets.symmetric(
                          vertical: float10,
                          horizontal: horizontalMargin,
                        ),
                      ),
                      TextFieldComponent(
                        controller: profileController.emailController,
                        hintText: "Email",
                        margin: const EdgeInsets.symmetric(
                          vertical: float10,
                          horizontal: horizontalMargin,
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value != null) {
                            if (!value.isEmail) {
                              return "Please enter a valid email";
                            }
                          }
                          return null;
                        },
                      ),
                      CommonButton(
                        btnText: "Update",
                        isEnabled:
                            profileController.emailController.text.isEmail,
                        margin: const EdgeInsets.symmetric(
                          horizontal: horizontalMargin,
                          vertical: float10,
                        ),
                        onTap: () async {
                          closeSoftKeyBoard();
                          controller.updateProfile(
                            name: profileController.nameController.text.trim(),
                            email:
                                profileController.emailController.text.trim(),
                          );
                        },
                      )
                    ],
                  ),
                ));
    });
  }
}
