import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../model/home_items.dart';

class HomeController extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }


  static const List<HomeItem> items = [
    HomeItem('Global', FontAwesomeIcons.globe, '/global'),
    HomeItem('Register', FontAwesomeIcons.userPlus, '/register'),
    HomeItem('Login', FontAwesomeIcons.rightToBracket, '/login_patient'),
    HomeItem('Hospital', FontAwesomeIcons.hospital, '/hospital'),
    HomeItem('Doctor', FontAwesomeIcons.userDoctor, '/doctor'),
    HomeItem('Ambulance', FontAwesomeIcons.truckMedical, '/ambulance'),
    HomeItem('Patient', FontAwesomeIcons.addressCard, '/patient_details'),
  ];
}
