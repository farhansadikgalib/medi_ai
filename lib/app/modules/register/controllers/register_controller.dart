import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/generated/assets.dart';

import '../../../core/helper/print_log.dart';

enum UserType { patient, hospital, ambulance }

class RegisterController extends GetxController {
  final pageController = PageController();
  int currentPage = 0;

  bool showAgreement = false;
  bool showUserTypeSelection = false;
  bool agreeTerms = false;
  bool agreePrivacy = false;

  UserType? selectedUserType;

  final titles = ['Welcome', 'Discover', 'Connect'];

  final subtitles = [
    'Start your journey',
    'Find new features',
    'Meet new people',
  ];

  final images = [
    Assets.dashboardIconsL1,
    Assets.categoryIconsEmergencyRoom,
    Assets.categoryIconsRehabilitation,
  ];

  void onPageChanged(int index) {
    currentPage = index;
    update();
  }

  void showAgreementSection() {
    showAgreement = true;
    update();
  }

  void setAgreeTerms(bool value) {
    agreeTerms = value;
    update();
  }

  void setAgreePrivacy(bool value) {
    agreePrivacy = value;
    update();
  }

  void showUserTypeSelectionSection() {
    showUserTypeSelection = true;
    update();
  }

  void selectUserType(UserType type) {
    selectedUserType = type;
    update();
    // Handle further navigation or logic here if needed
    printLog('Selected user type: $type');
  }
}
