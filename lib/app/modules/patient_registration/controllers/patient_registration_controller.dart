
    import 'package:flutter/material.dart';
    import 'package:get/get.dart';

    class PatientRegistrationController extends GetxController {
      final pageController = PageController();

      // Page 1
      final phoneController = TextEditingController();
      final emailController = TextEditingController();
      final passwordController = TextEditingController();
      var isPasswordVisible = false.obs;
      var countryCode = '+1'.obs;

      // Page 2
      final firstNameController = TextEditingController();
      final lastNameController = TextEditingController();
      final dobController = TextEditingController();
      final ageController = TextEditingController();
      var gender = 'Male'.obs;
      var bloodType = 'A+'.obs;
      final heightController = TextEditingController();
      final weightController = TextEditingController();
      final countryController = TextEditingController();
      final prefectureController = TextEditingController();
      final address1Controller = TextEditingController();
      final address2Controller = TextEditingController();
      final cityController = TextEditingController();
      final postalCodeController = TextEditingController();

      void goToNextPage() {
        pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        update();
      }

      void goToPreviousPage() {
        pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        update();
      }

      void pickDateOfBirth() async {
        DateTime? picked = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime(2000, 1, 1),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          dobController.text = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
          final now = DateTime.now();
          int age = now.year - picked.year;
          if (now.month < picked.month || (now.month == picked.month && now.day < picked.day)) {
            age--;
          }
          ageController.text = age.toString();
          update();
        }
      }

      void submitRegistration() {
        Get.snackbar('Success', 'Registration submitted!');
      }
    }