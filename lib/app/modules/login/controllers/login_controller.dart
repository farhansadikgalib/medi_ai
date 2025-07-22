import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medi/app/core/config/app_config.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/routes/app_pages.dart';

import '../../../core/helper/auth_helper.dart';
import '../../../remote/repository/auth/auth_repository.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  var countryCode = '+1'.obs;
  var tabIndex = 0.obs;
  final isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      emailController.text = 'farhansadikgalib@gmail.com';
      passwordController.text = '12345678';
    }
  }

void login() async {
    if (tabIndex.value == 0) {
      // Email login
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      if (!emailRegex.hasMatch(email)) {
        AppWidgets().getSnackBar(title: "Error", message: "Invalid email format");
        return;
      }
      var response = await AuthRepository().getSignIn(email, password);
      if (response.success == true) {
        await AuthHelper().setUserData(response, DateTime.now().toIso8601String());
        Get.offAllNamed(Routes.HOME);
      } else {
        AppWidgets().getSnackBar(title: "Info", message: response.message);
      }
    } else {
      // Phone login
      final phone = phoneController.text.trim();
      final password = passwordController.text.trim();
      printLog( countryCode+phone);
    /*  var response = await AuthRepository().getSignInWithPhone(countryCode.value + phone, password);
      if (response.success == true) {
        await AuthHelper().setUserData(response, DateTime.now().toIso8601String());
        Get.offAllNamed(Routes.HOME);
      } else {
        AppWidgets().getSnackBar(title: "Info", message: response.message);
      }*/
    }
  }
  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
