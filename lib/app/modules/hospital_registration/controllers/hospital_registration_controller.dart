import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medi/app/modules/hospital_registration/model/operating_hours_entry.dart';

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

  // Page 3
  final nameController = TextEditingController();
  final dayPhoneController = TextEditingController();
  final locationController = TextEditingController();
  final nightPhoneController = TextEditingController();
  final emailPage3Controller = TextEditingController();
  final countryPage3Controller = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postcodeController = TextEditingController();
  final currencyController = TextEditingController();
  final consumptionTaxController = TextEditingController();
  final buildingNameController = TextEditingController();
  final numberOfRoomsController = TextEditingController();
  final websiteUrlController = TextEditingController();
  var dayPhoneCountryCode = '+1'.obs;
  var nightPhoneCountryCode = '+1'.obs;

  var hasParking = false.obs;
  var isWheelchairAccessible = false.obs;
  var hasWheelchairToilet = false.obs;
  var hasVisualSupport = false.obs;
  var hasHearingSupport = false.obs;
  var hasForeignLanguageSupport = false.obs;

  // Page 3 - Departments
  final List<String> departments = [
    "Internal Medicine",
    "Surgical System",
    "Pediatrics",
    "Obstetrics",
    "Ophthalmology",
    "Dermatology",
    "Psychiatry",
    "Dental System",
    "Other Surgery",
  ];

  final Map<String, List<String>> subSpecialties = {
    "Internal Medicine": [
      "Internal Medicine",
      "Neurology",
      "Respiratory Department",
      "Department of Gastroenterology",
      "Gastroenterology",
      "Cardiology",
      "Tracheoesophageal Department",
      "Respiratory Medicine",
      "Gastrointestinal Medicine",
      "Nephrology",
      "Diabetes Internal Medicine",
      "Artificial Dialysis Internal Medicine",
      "Chinese Medicine Medicine",
    ],
    "Surgical System": [
      "Surgery",
      "Orthopedic Surgery",
      "Plastic Surgery",
      "Cosmetic Surgery",
      "Neurosurgery",
      "Respiratory Surgery",
      "Cardiovascular Surgery",
      "Department of Phylum",
      "Breast Surgery",
      "Digestive Surgery",
      "Komon Surgery",
    ],
    "Pediatrics": ["Pediatrics", "Pediatrics Surgery"],
    "Obstetrics": ["Obstetrics and Gynecology", "Obstetrics", "Gynecology"],
    "Ophthalmology": ["Ophthalmology", "Otorhinolaryngology"],
    "Dermatology": [
      "Dermatology",
      "Urology",
      "Venereal Disease Department",
      "Dermatology Urology",
      "Cosmetic Dermatology",
    ],
    "Psychiatry": ["Psychiatry", "Psychosomatic Medicine", "Neurology"],
    "Dental System": [
      "Dental",
      "Orthodontics",
      "Pediatric Dentistry",
      "Dental and Oral Surgery",
    ],
    "Other Surgery": [
      "Allergy Department",
      "Rheumatology",
      "Department of Rehabilitation",
      "Radiology",
      "Radiology Department",
      "Radiation therapy department",
      "Department of Pathology",
      "clinical laboratory department",
      "Emergency Department",
      "Anesthesiology",
    ],
  };

  var selectedDepartment = ''.obs;
  var subSpecialtyStates = <String, bool>{}.obs;

  void selectDepartment(String department) {
    if (selectedDepartment.value == department) {
      selectedDepartment.value = '';
    } else {
      selectedDepartment.value = department;
    }
  }

  void toggleSubSpecialty(String specialty, bool? value) {
    subSpecialtyStates[specialty] = value ?? false;
  }

  // Page 4: Image upload
  final uploadedImages = <XFile>[].obs;

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    uploadedImages.addAll(images);
  }

  void removeImage(int index) {
    uploadedImages.removeAt(index);
  }

  // Page 5: Operating Hours
  final RxList<OperatingHoursEntry> firstOpeningHours =
      <OperatingHoursEntry>[].obs;
  final RxList<OperatingHoursEntry> secondOpeningHours =
      <OperatingHoursEntry>[].obs;
  final List<String> weekdays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  @override
  void onInit() {
    for (var day in weekdays) {
      firstOpeningHours.add(OperatingHoursEntry(day));
      secondOpeningHours.add(OperatingHoursEntry(day));
    }
    super.onInit();
  }

  Future<void> pickTime(BuildContext context, Rx<TimeOfDay?> time) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time.value ?? TimeOfDay.now(),
    );
    if (picked != null && picked != time.value) {
      time.value = picked;
    }
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

  void submitRegistration() {
    // TODO: Implement registration submission
    Get.snackbar('Success', 'Registration submitted!');
  }
}
