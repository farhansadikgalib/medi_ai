import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';
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

  final titles = [
    'Travel with confidence, knowing you\'re safe wherever you '
        'go',
    'Talk or chat with hospital staff and medical professionals in any language using MediAi',
    'Let\'s get started!',
  ];

  final subtitles = [
    'Count on MediAi to assist in diagnosing health situations and identifying the closest and most suitable hospital for your needs',
    'Instantly chat in any language with hospital staff and medical professionals using MediAi',
    'Manage your medical data, initiate one-click ambulance calls, experience real-time chat translation, enjoy live voice-to-text translation, share personal chat room with medical facilities, and more—all in one place',
  ];

  final images = [Assets.register1, Assets.register2, Assets.register3];

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
