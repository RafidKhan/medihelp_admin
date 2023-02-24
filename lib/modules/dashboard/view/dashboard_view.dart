import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/components/app_bar_widget.dart';
import 'package:medihelp_admin/components/default_scaffold.dart';
import 'package:medihelp_admin/gen/assets.gen.dart';
import 'package:medihelp_admin/modules/dashboard/controller/dashboard_controller.dart';
import 'package:medihelp_admin/modules/dashboard/view/medicines_view.dart';
import 'package:medihelp_admin/modules/dashboard/view/tab_view.dart';
import 'package:medihelp_admin/utils/styles.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    // TODO: implement initState
    dashboardController.fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return DefaultScaffold(
        backgroundColor: kBackgroundColor,
        appBar: const AppbarWidget(
          title: "MediHelp",
          hideBackButton: true,
        ),
        body: SingleChildScrollView(
          physics: bouncingPhysics,
          child: Column(
            children: const [
              TabView(),
              MedicinesView(),
            ],
          ),
        ),
      );
    });
  }
}
