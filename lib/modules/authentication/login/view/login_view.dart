import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/base/base_state.dart';
import 'package:medihelp_admin/components/common_button.dart';
import 'package:medihelp_admin/components/default_scaffold.dart';
import 'package:medihelp_admin/components/text_component.dart';
import 'package:medihelp_admin/components/text_field_component.dart';
import 'package:medihelp_admin/modules/authentication/controller/auth_controller.dart';
import 'package:medihelp_admin/modules/authentication/login/view/otp_view.dart';
import 'package:medihelp_admin/utils/common_methods.dart';
import 'package:medihelp_admin/utils/styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView> {
  final authController = Get.put(AuthController());

  late Rxn<String?> loginPhoneNumber;
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    loginPhoneNumber = authController.loginPhoneNumber;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    resetGetXValues([loginPhoneNumber]);
    phoneController.dispose();
    closeSoftKeyBoard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return DefaultScaffold(
          backgroundColor: kBackgroundColor,
          body: SingleChildScrollView(
            physics: bouncingPhysics,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const TextComponent(
                  "Login",
                  fontSize: fontSize22,
                  fontWeight: fontWeight700,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalMargin,
                    vertical: float10,
                  ),
                ),
                const TextComponent(
                  "Enter Phone Number",
                  fontSize: fontSize18,
                  fontWeight: fontWeight500,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalMargin,
                    vertical: float10,
                  ),
                ),
                TextFieldComponent(
                  controller: phoneController,
                  hintText: "Phone number",
                  keyboardType: TextInputType.phone,
                  margin: const EdgeInsets.only(
                    left: horizontalMargin,
                    right: horizontalMargin,
                    bottom: float10,
                  ),
                  onChanged: (value) {
                    loginPhoneNumber.value = value;
                  },
                ),
                Obx(
                  () => CommonButton(
                    btnText: "Send OTP",
                    isEnabled: !isBlank([loginPhoneNumber]),
                    margin: const EdgeInsets.symmetric(
                      horizontal: horizontalMargin,
                      vertical: float10,
                    ),
                    onTap: () {
                      closeSoftKeyBoard();
                      Get.to(
                        () => const OtpView(),
                        transition: defaultPageTransition,
                      );
                    },
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
