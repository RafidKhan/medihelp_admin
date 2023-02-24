import 'package:get/get.dart';
import 'package:medihelp_admin/modules/add_medicine/view/add_medicine.dart';
import 'package:medihelp_admin/modules/dashboard/view/dashboard_view.dart';
import 'package:medihelp_admin/modules/orders/view/main_list_view/orders_view.dart';
import 'package:medihelp_admin/modules/profile/view/profile_view.dart';

class BottomNavController extends GetxController {
  int tabIndex = 0;
  final tabs = [
    const DashboardView(),
    const AddMedicine(),
    const OrdersView(),
    const ProfileView(),
  ];
}
