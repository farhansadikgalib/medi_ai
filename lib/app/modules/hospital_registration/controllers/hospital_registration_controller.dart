import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HospitalRegistrationController extends GetxController {
  final pageController = PageController();

  // Page 1
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var countryCode = '+1'.obs;

  // Page 2
  var selectedType = ''.obs;

  void selectType(String type) {
    selectedType.value = type;
  }

  // Navigation
  void goToNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    update();
  }

  void goToPreviousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    update();
  }
}
