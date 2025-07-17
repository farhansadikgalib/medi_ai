import 'dart:ui';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medi/core/base/base_controller.dart';

import '../../../routes/app_pages.dart';
import '../model/home_items.dart';

class HomeController extends BaseController {
  double? radius;
  Offset? center;

  void calculateCircle(Size size) {
    if (radius == null || center == null) {
      radius = size.width * 0.35;
      center = Offset(size.width / 2, size.height / 2);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  static const List<HomeItem> items = [
    HomeItem('Global', FontAwesomeIcons.globe, Routes.GLOBAL),
    HomeItem('Register', FontAwesomeIcons.userPlus, Routes.REGISTER),
    HomeItem('Login', FontAwesomeIcons.rightToBracket, Routes.LOGIN),
    HomeItem('Hospital', FontAwesomeIcons.hospital, Routes.HOSPITAL),
    HomeItem('Doctor', FontAwesomeIcons.userDoctor, Routes.DOCTOR),
    HomeItem('Ambulance', FontAwesomeIcons.truckMedical, Routes.AMBULANCE),
    HomeItem('Patient', FontAwesomeIcons.addressCard, Routes.PATIENT),
  ];
}
