import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medi/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  var countryCode = '+1'.obs;
  var tabIndex = 0.obs;
  final isPasswordVisible = false.obs;

  void login() {
    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
