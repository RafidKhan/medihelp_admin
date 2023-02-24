import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/components/default_scaffold.dart';
import 'package:medihelp_admin/gen/assets.gen.dart';
import 'package:medihelp_admin/modules/bottom_nav_page/controller/bottom_nav_controller.dart';
import 'package:medihelp_admin/utils/styles.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  var bottomNavController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(builder: (controller) {
      return DefaultScaffold(
          body: IndexedStack(
              index: controller.tabIndex, children: controller.tabs),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.tabIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              bottomNavItem(asset: Assets.icons.iconHome.path),
              bottomNavItem(asset: Assets.icons.iconAdd.path),
              bottomNavItem(asset: Assets.icons.iconOrders.path),
              bottomNavItem(asset: Assets.icons.user.path),
            ],
            backgroundColor: kPrimaryColor,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedItemColor: kPrimaryColor,
            selectedFontSize: fontSize12,
            unselectedFontSize: fontSize12,
            unselectedItemColor: Colors.transparent,
            onTap: (int i) {
              controller.tabIndex = i;
              controller.update();
            },
          ));
    });
  }

  Widget activeIcon({required String asset}) {
    return Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: kSecondaryColor),
        child: Center(
            child: Image.asset(
          asset,
          color: kWhiteColor,
        )));
  }

  Widget inactiveIcon({required String asset}) {
    return Container(
        padding: const EdgeInsets.all(7),
        height: 40,
        width: 40,
        child: Image.asset(
          asset,
          color: kWhiteColor,
        ));
  }

  BottomNavigationBarItem bottomNavItem({required String asset}) {
    return BottomNavigationBarItem(
        icon: inactiveIcon(asset: asset),
        activeIcon: activeIcon(asset: asset),
        label: "",
        backgroundColor: kPrimaryColor);
  }
}
