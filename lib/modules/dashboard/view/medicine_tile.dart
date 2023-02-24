import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medihelp_admin/components/loader_widget.dart';
import 'package:medihelp_admin/components/text_component.dart';
import 'package:medihelp_admin/gen/assets.gen.dart';
import 'package:medihelp_admin/models/medicine_model.dart';
import 'package:medihelp_admin/utils/styles.dart';

class MedicineTile extends StatelessWidget {
  MedicineModel medicineModel;
  double height;

  MedicineTile({
    Key? key,
    required this.medicineModel,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: float10,
      ),
      padding: const EdgeInsets.all(
        float10,
      ),
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(
            15,
          ),
          boxShadow: const [defaultBoxShadow]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: LoaderWidget(
                  size: 10,
                ),
              ),
              errorWidget: (context, url, error) {
                return Image.asset(
                  Assets.logo.appLogo.path,
                  height: height / 2,
                );
              },
              imageUrl: medicineModel.image ?? "",
              height: height / 2,
              width: MediaQuery.of(context).size.width / 3,
              fit: BoxFit.fill,
            ),
          ),
          TextComponent(
            medicineModel.name ?? "",
            fontSize: fontSize14,
            fontWeight: fontWeight500,
            textAlign: TextAlign.start,
          ),
          TextComponent(
            "${(medicineModel.price ?? "")} BDT",
            fontSize: fontSize12,
            fontWeight: fontWeight400,
            textAlign: TextAlign.start,
            padding: const EdgeInsets.only(
              top: float5,
            ),
          ),
        ],
      ),
    );
  }
}
