import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../model/home_items.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  static const List<HomeItem> items = [
    HomeItem('Global', FontAwesomeIcons.globe, Routes.GLOBAL),
    HomeItem('Register', FontAwesomeIcons.userPlus, Routes.REGISTER),
    HomeItem('Login', FontAwesomeIcons.rightToBracket, Routes.REGISTER),
    HomeItem('Hospital', FontAwesomeIcons.hospital, Routes.HOSPITAL),
    HomeItem('Doctor', FontAwesomeIcons.userDoctor, Routes.DOCTOR),
    HomeItem('Ambulance', FontAwesomeIcons.truckMedical, Routes.AMBULANCE),
    HomeItem('Patient', FontAwesomeIcons.addressCard, Routes.PATIENT),
  ];
}
