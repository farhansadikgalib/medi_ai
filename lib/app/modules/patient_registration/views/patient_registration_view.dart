import 'package:clay_containers/widgets/clay_container.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/core/helper/app_widgets.dart';
import '../../../../core/style/app_colors.dart';
import '../controllers/patient_registration_controller.dart';

class PatientRegistrationView extends GetView<PatientRegistrationController> {
  const PatientRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Container(
          width: Get.width / 1.10,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: GetBuilder<PatientRegistrationController>(
            builder: (controller) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Page 1: Phone, Email, Password
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            AppWidgets().gapH24(),
                            ClayContainer(
                              color: AppColors.primaryColor,
                              borderRadius: 60,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.person_add_alt_1,
                                  size: 48,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                ClayContainer(
                                  color: AppColors.primaryColor,
                                  borderRadius: 8,
                                  child: CountryCodePicker(
                                    onChanged: (country) =>
                                        controller.countryCode.value =
                                            country.dialCode ?? '',
                                    initialSelection:
                                        controller.countryCode.value.isNotEmpty
                                        ? controller.countryCode.value
                                        : '+1',
                                    favorite: const ['+1', '+91'],
                                    showCountryOnly: false,
                                    showOnlyCountryWhenClosed: false,
                                    alignLeft: false,
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller: controller.phoneController,
                                        keyboardType: TextInputType.phone,
                                        decoration: const InputDecoration(
                                          labelText: 'Phone',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ClayContainer(
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: TextField(
                                  controller: controller.emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Obx(
                              () => ClayContainer(
                                color: AppColors.primaryColor,
                                borderRadius: 8,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: TextField(
                                    controller: controller.passwordController,
                                    obscureText:
                                        !controller.isPasswordVisible.value,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          controller.isPasswordVisible.value
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColors.primaryAccentColor,
                                        ),
                                        onPressed: () {
                                          controller.isPasswordVisible.value =
                                              !controller
                                                  .isPasswordVisible
                                                  .value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: controller.goToNextPage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryAccentColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text('Continue'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Page 2: Personal & Address Details
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ClayContainer(
                              color: AppColors.primaryColor,
                              borderRadius: 60,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.assignment_ind,
                                  size: 48,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller:
                                            controller.firstNameController,
                                        decoration: const InputDecoration(
                                          labelText: 'First Name',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller:
                                            controller.lastNameController,
                                        decoration: const InputDecoration(
                                          labelText: 'Last Name',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller: controller.dobController,
                                        readOnly: true,
                                        onTap: controller.pickDateOfBirth,
                                        decoration: const InputDecoration(
                                          labelText: 'Date of Birth',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller: controller.ageController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelText: 'Age',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        value: controller.gender.value.isEmpty
                                            ? null
                                            : controller.gender.value,
                                        items: ['Male', 'Female', 'Other']
                                            .map(
                                              (g) => DropdownMenuItem(
                                                value: g,
                                                child: Text(g),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (val) =>
                                            controller.gender.value = val ?? '',
                                        decoration: const InputDecoration(
                                          labelText: 'Gender',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        value:
                                            controller.bloodType.value.isEmpty
                                            ? null
                                            : controller.bloodType.value,
                                        items:
                                            [
                                                  'A+',
                                                  'A-',
                                                  'B+',
                                                  'B-',
                                                  'AB+',
                                                  'AB-',
                                                  'O+',
                                                  'O-',
                                                ]
                                                .map(
                                                  (b) => DropdownMenuItem(
                                                    value: b,
                                                    child: Text(b),
                                                  ),
                                                )
                                                .toList(),
                                        onChanged: (val) =>
                                            controller.bloodType.value =
                                                val ?? '',
                                        decoration: const InputDecoration(
                                          labelText: 'Blood Type',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller: controller.heightController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelText: 'Height (cm)',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller: controller.weightController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelText: 'Weight (kg)',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ClayContainer(
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: TextField(
                                  controller: controller.countryController,
                                  decoration: const InputDecoration(
                                    labelText: 'Country of Residence',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ClayContainer(
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: TextField(
                                  controller: controller.prefectureController,
                                  decoration: const InputDecoration(
                                    labelText: 'Prefecture',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ClayContainer(
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: TextField(
                                  controller: controller.address1Controller,
                                  decoration: const InputDecoration(
                                    labelText: 'Address 1',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ClayContainer(
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: TextField(
                                  controller: controller.address2Controller,
                                  decoration: const InputDecoration(
                                    labelText: 'Address 2',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller: controller.cityController,
                                        decoration: const InputDecoration(
                                          labelText: 'City Name',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller:
                                            controller.postalCodeController,
                                        decoration: const InputDecoration(
                                          labelText: 'Postal Code',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.goToPreviousPage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white12,
                                        foregroundColor:
                                            AppColors.primaryAccentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: const Text('Back'),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.submitRegistration,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.primaryAccentColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: const Text('Next'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
