import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medihelp_admin/components/loader_widget.dart';
import 'package:medihelp_admin/components/text_component.dart';
import 'package:medihelp_admin/gen/assets.gen.dart';
import 'package:medihelp_admin/models/user_model.dart';
import 'package:medihelp_admin/utils/styles.dart';

class UserDataView extends StatelessWidget {
  UserModel userModel;

  UserDataView({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.only(
              top: float24,
              bottom: float12,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: LoaderWidget(
                    size: 10,
                  ),
                ),
                errorWidget: (context, url, error) {
                  return Image.asset(
                    Assets.logo.appLogo.path,
                    height: 100,
                    width: 100,
                  );
                },
                imageUrl: userModel.profilePicture ?? "",
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        TextComponent(
          userModel.name ?? "Name not Found",
          fontSize: fontSize18,
          fontWeight: fontWeight600,
          color: kSecondaryColor,
          padding: const EdgeInsets.only(
            bottom: float10,
          ),
        ),
        TextComponent(
          userModel.email ?? "Email not found",
          fontSize: fontSize16,
          fontWeight: fontWeight400,
          padding: const EdgeInsets.only(
            bottom: float10,
          ),
        ),
        TextComponent(
          userModel.phoneNumber ?? "Phone number not found",
          fontSize: fontSize16,
          fontWeight: fontWeight400,
          padding: const EdgeInsets.only(
            bottom: float10,
          ),
        ),
      ],
    );
  }
}
