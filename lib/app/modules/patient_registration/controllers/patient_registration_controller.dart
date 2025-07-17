import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medi/app/routes/app_pages.dart';
import '../model/vaccination_entry.dart';
import '../model/emergency_contact_entry.dart';

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
  var gender = ''.obs;
  var bloodType = ''.obs;
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final countryController = TextEditingController();
  final prefectureController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();

  // Page 3: Medical dropdowns
  var currentMedicalCondition = ''.obs;
  var diagnosedCondition = ''.obs;
  var surgicalHistory = ''.obs;
  var allergies = ''.obs;
  var underMedication = ''.obs;

  // Page 4: Vaccination entries
  RxList<VaccinationEntry> vaccinations = <VaccinationEntry>[VaccinationEntry()].obs;

  void addVaccinationEntry() {
    vaccinations.add(VaccinationEntry());
    update();
  }

  void removeVaccinationEntry(int index) {
    if (index > 0) {
      vaccinations.removeAt(index);
      update();
    }
  }

  Future<void> pickVaccinationDate(int index) async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      vaccinations[index].date.value = picked;
      update();
    }
  }

  // Page 5: Emergency contacts
  RxList<EmergencyContactEntry> emergencyContacts = <EmergencyContactEntry>[EmergencyContactEntry()].obs;

  void addEmergencyContactEntry() {
    emergencyContacts.add(EmergencyContactEntry());
    update();
  }

  void removeEmergencyContactEntry(int index) {
    if (index > 0) {
      emergencyContacts.removeAt(index);
      update();
    }
  }

  // Page 6: Lifestyle and preferences

  final smokingHabits = ''.obs;
  final alcoholConsumption = ''.obs;
  final physicalActivity = ''.obs;
  final preferences = ''.obs;


  // Page 7: Image upload

  final uploadedImages = <XFile>[].obs;


  Future<void> pickImages() async {

    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      uploadedImages.addAll(images);
    }
  }

  void removeImage(int index) {
    uploadedImages.removeAt(index);
  }


  // Navigation
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
    Get.toNamed(Routes.HOME);
    Get.snackbar('Success', 'Registration submitted!');
  }
}