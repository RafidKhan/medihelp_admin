import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/components/app_bar_widget.dart';
import 'package:medihelp_admin/components/default_scaffold.dart';
import 'package:medihelp_admin/components/loader_widget.dart';
import 'package:medihelp_admin/modules/profile/controller/profile_controller.dart';
import 'package:medihelp_admin/modules/profile/view/edit_profile.dart';
import 'package:medihelp_admin/modules/profile/view/profile_info.dart';
import 'package:medihelp_admin/utils/common_methods.dart';
import 'package:medihelp_admin/utils/styles.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    profileController.getProfileData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return DefaultScaffold(
          appBar: AppbarWidget(
            title: 'Profile',
            hideBackButton: true,
            prefixWidget: Container(
              margin: const EdgeInsets.only(
                right: horizontalMargin,
              ),
              child: InkWell(
                  onTap: () {
                    logoutUser();
                  },
                  child: const Icon(Icons.logout)),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: kSecondaryColor,
            onPressed: () {
              Get.to(
                    () => const EditProfile(),
                transition: defaultPageTransition,
              );
            },
            child: const Icon(Icons.edit),
          ),
          body: controller.myProfileData == null &&
                  controller.loadingLocation == true
              ? LoaderWidget()
              : SingleChildScrollView(
                  physics: bouncingPhysics,
                  child: Column(
                    children: const [
                      ProfileInfo(),
                    ],
                  ),
                ));
    });
  }
}
