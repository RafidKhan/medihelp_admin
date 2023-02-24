import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/base/base_state.dart';
import 'package:medihelp_admin/components/common_button.dart';
import 'package:medihelp_admin/components/default_scaffold.dart';
import 'package:medihelp_admin/components/text_component.dart';
import 'package:medihelp_admin/components/text_field_component.dart';
import 'package:medihelp_admin/modules/authentication/controller/auth_controller.dart';
import 'package:medihelp_admin/utils/common_methods.dart';
import 'package:medihelp_admin/utils/styles.dart';

class OtpView extends StatefulWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends BaseState<OtpView> {
  final authController = Get.put(AuthController());

  late Rxn<String?> otpValue;
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    authController.getLoginOtp();
    otpValue = authController.otpValue;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    resetGetXValues([otpValue]);
    otpController.dispose();
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
                  "Enter OTP",
                  fontSize: fontSize18,
                  fontWeight: fontWeight500,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalMargin,
                    vertical: float10,
                  ),
                ),
                TextFieldComponent(
                  controller: otpController,
                  hintText: "otp",
                  keyboardType: TextInputType.phone,
                  margin: const EdgeInsets.only(
                    left: horizontalMargin,
                    right: horizontalMargin,
                    bottom: float10,
                  ),
                  onChanged: (value) {
                    otpValue.value = value;
                  },
                  validator: (value) {
                    if (value != null) {
                      if (value.length > 6 || value.length < 6) {
                        return "OTP should be 6 digits long";
                      }
                    }
                    return null;
                  },
                ),
                Obx(
                  () => CommonButton(
                    btnText: "Login",
                    isEnabled: !isBlank([otpValue]),
                    isLoading: controller.verifyButtonLoading.value,
                    margin: const EdgeInsets.symmetric(
                      horizontal: horizontalMargin,
                      vertical: float10,
                    ),
                    onTap: () {
                      closeSoftKeyBoard();
                      controller.verifyPhoneLogin();
                    },
                  ),
                )
              ],
            ),
          ));
    });
  }
}
