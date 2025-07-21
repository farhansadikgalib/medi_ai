import 'dart:io';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import '../../../core/style/app_colors.dart';
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
                              depth: 12,
                              spread: 6,
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
                                  depth: 16,
                                  spread: 2,
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
                                    depth: 16,
                                    spread: 2,
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
                              depth: 16,
                              spread: 2,
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
                                depth: 16,
                                spread: 2,
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
                              depth: 16,
                              spread: 2,
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
                                    depth: 16,
                                    spread: 2,
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
                                    depth: 16,
                                    spread: 2,
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
                                    depth: 16,
                                    spread: 2,
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
                                    depth: 16,
                                    spread: 2,
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
                                    depth: 16,
                                    spread: 2,
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
                                        items: ['Male', 'Female']
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
                                    depth: 16,
                                    spread: 2,
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
                                                  'I\'m not sure',
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
                                    depth: 16,
                                    spread: 2,
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
                                    depth: 16,
                                    spread: 2,
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
                              depth: 16,
                              spread: 2,
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
                              depth: 16,
                              spread: 2,
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
                              depth: 16,
                              spread: 2,
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
                              depth: 16,
                              spread: 2,
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
                                    depth: 16,
                                    spread: 2,
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
                                    depth: 16,
                                    spread: 2,
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
                                      onPressed: controller.goToNextPage,
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
                      // Page 3: Medical Details
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 60,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.medical_services,
                                  size: 48,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: DropdownButtonFormField<String>(
                                  value:
                                      controller
                                          .currentMedicalCondition
                                          .value
                                          .isEmpty
                                      ? null
                                      : controller
                                            .currentMedicalCondition
                                            .value,
                                  items:
                                      [
                                            'Select an option',
                                            'Healthy individual',
                                            'Healthy under medication',
                                            'Healthy undergoing medical preventive',
                                            'Healthy undergoing medical treatment',
                                            'Healthy with a medical history',
                                            'Healthy with disability',
                                            'Unhealthy individual',
                                            'Unhealthy undergoing medical treatment',
                                          ]
                                          .map(
                                            (c) => DropdownMenuItem(
                                              value: c == 'Select an option'
                                                  ? ''
                                                  : c,
                                              child: Text(c),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) =>
                                      controller.currentMedicalCondition.value =
                                          val ?? '',
                                  decoration: const InputDecoration(
                                    labelText:
                                        'What is your current medical condition?',
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
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: DropdownButtonFormField<String>(
                                  value:
                                      controller
                                          .diagnosedCondition
                                          .value
                                          .isEmpty
                                      ? null
                                      : controller.diagnosedCondition.value,
                                  items:
                                      [
                                            'None',
                                            'Cancer',
                                            'Stroke',
                                            'Kidney Disease',
                                            'Liver Disease',
                                            'Other',
                                          ]
                                          .map(
                                            (c) => DropdownMenuItem(
                                              value: c,
                                              child: Text(c),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) =>
                                      controller.diagnosedCondition.value =
                                          val ?? '',
                                  decoration: const InputDecoration(
                                    labelText:
                                        'Please indicate if you have ever been diagnosed with any of the following conditions:',
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
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: DropdownButtonFormField<String>(
                                  value:
                                      controller.surgicalHistory.value.isEmpty
                                      ? null
                                      : controller.surgicalHistory.value,
                                  items:
                                      [
                                            'None',
                                            'Appendectomy',
                                            'Gallbladder removal',
                                            'Heart surgery',
                                            'Other',
                                          ]
                                          .map(
                                            (c) => DropdownMenuItem(
                                              value: c,
                                              child: Text(c),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) =>
                                      controller.surgicalHistory.value =
                                          val ?? '',
                                  decoration: const InputDecoration(
                                    labelText: 'What is your surgical history?',
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
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: controller.allergies.value.isEmpty
                                      ? null
                                      : controller.allergies.value,
                                  items:
                                      [
                                            'None',
                                            'Penicillin',
                                            'Peanuts',
                                            'Latex',
                                            'Other',
                                          ]
                                          .map(
                                            (c) => DropdownMenuItem(
                                              value: c,
                                              child: Text(c),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) =>
                                      controller.allergies.value = val ?? '',
                                  decoration: const InputDecoration(
                                    labelText: 'Allergies',
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
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: DropdownButtonFormField<String>(
                                  value:
                                      controller.underMedication.value.isEmpty
                                      ? null
                                      : controller.underMedication.value,
                                  items: ['No', 'Yes']
                                      .map(
                                        (c) => DropdownMenuItem(
                                          value: c,
                                          child: Text(c),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) =>
                                      controller.underMedication.value =
                                          val ?? '',
                                  decoration: const InputDecoration(
                                    labelText:
                                        'Are you under any medications?*',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
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
                                      onPressed: controller.goToNextPage,
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
                      // Page 4: Vaccination List
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 60,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.vaccines,
                                  size: 48,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Obx(
                              () => Column(
                                children: List.generate(
                                  controller.vaccinations.length,
                                  (index) {
                                    final entry =
                                        controller.vaccinations[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: DropdownButtonFormField<String>(
                                              value:
                                                  entry
                                                      .vaccineType
                                                      .value
                                                      .isEmpty
                                                  ? null
                                                  : entry.vaccineType.value,
                                              items:
                                                  [
                                                        'COVID-19',
                                                        'Influenza',
                                                        'Hepatitis B',
                                                        'Tetanus',
                                                        'Other',
                                                      ]
                                                      .map(
                                                        (c) => DropdownMenuItem(
                                                          value: c,
                                                          child: Text(c),
                                                        ),
                                                      )
                                                      .toList(),
                                              onChanged: (val) =>
                                                  entry.vaccineType.value =
                                                      val ?? '',
                                              decoration: const InputDecoration(
                                                labelText:
                                                    'Any vaccinations you might have had in the past 12 Month?',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: TextField(
                                              controller:
                                                  entry.vaccineNameController,
                                              decoration: const InputDecoration(
                                                labelText: 'Vaccines',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: ListTile(
                                            title: Text(
                                              entry.date.value == null
                                                  ? 'Select Date'
                                                  : '${entry.date.value!.year}-${entry.date.value!.month.toString().padLeft(2, '0')}-${entry.date.value!.day.toString().padLeft(2, '0')}',
                                            ),
                                            trailing: const Icon(
                                              Icons.calendar_today,
                                            ),
                                            onTap: () => controller
                                                .pickVaccinationDate(index),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (index > 0)
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () => controller
                                                    .removeVaccinationEntry(
                                                      index,
                                                    ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: controller.addVaccinationEntry,
                                  icon: const Icon(Icons.add),
                                  label: const Text('Add'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.primaryAccentColor,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
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
                                      onPressed: controller.goToNextPage,
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
                      // Page 5: Emergency Contacts
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 60,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.contact_phone,
                                  size: 48,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Obx(
                              () => Column(
                                children: List.generate(
                                  controller.emergencyContacts.length,
                                  (index) {
                                    final entry =
                                        controller.emergencyContacts[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: TextField(
                                              controller: entry.nameController,
                                              decoration: const InputDecoration(
                                                labelText:
                                                    'Name of Emergency Contact',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: TextField(
                                              controller: entry.phoneController,
                                              decoration: const InputDecoration(
                                                labelText:
                                                    'Phone Number with country code',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: Obx(
                                              () => DropdownButtonFormField<String>(
                                                value:
                                                    entry
                                                        .relationship
                                                        .value
                                                        .isEmpty
                                                    ? null
                                                    : entry.relationship.value,
                                                items:
                                                    [
                                                          'Parent',
                                                          'Sibling',
                                                          'Spouse',
                                                          'Friend',
                                                          'Colleague',
                                                          'Other',
                                                        ]
                                                        .map(
                                                          (c) =>
                                                              DropdownMenuItem(
                                                                value: c,
                                                                child: Text(c),
                                                              ),
                                                        )
                                                        .toList(),
                                                onChanged: (val) =>
                                                    entry.relationship.value =
                                                        val ?? '',
                                                decoration:
                                                    const InputDecoration(
                                                      labelText: 'Relationship',
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                          ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: TextField(
                                              controller: entry.emailController,
                                              decoration: const InputDecoration(
                                                labelText: 'Email',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: TextField(
                                              controller:
                                                  entry.mediAiIdController,
                                              decoration: const InputDecoration(
                                                labelText: 'MediAi ID',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (index > 0)
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () => controller
                                                    .removeEmergencyContactEntry(
                                                      index,
                                                    ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed:
                                      controller.addEmergencyContactEntry,
                                  icon: const Icon(Icons.add),
                                  label: const Text('Add'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.primaryAccentColor,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
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
                                      onPressed: controller.goToNextPage,
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
                      // Page 6: Lifestyle and Preferences
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 60,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.health_and_safety,
                                  size: 48,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: controller.smokingHabits.value.isEmpty
                                      ? null
                                      : controller.smokingHabits.value,
                                  items:
                                      [
                                            'Non-smoker',
                                            'Occasional',
                                            'Regular',
                                            'Former smoker',
                                          ]
                                          .map(
                                            (s) => DropdownMenuItem(
                                              value: s,
                                              child: Text(s),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) =>
                                      controller.smokingHabits.value =
                                          val ?? '',
                                  decoration: const InputDecoration(
                                    labelText: 'Smoking Habits',
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
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: DropdownButtonFormField<String>(
                                  value:
                                      controller
                                          .alcoholConsumption
                                          .value
                                          .isEmpty
                                      ? null
                                      : controller.alcoholConsumption.value,
                                  items:
                                      [
                                            'Never',
                                            'Occasional',
                                            'Regular',
                                            'Former drinker',
                                          ]
                                          .map(
                                            (a) => DropdownMenuItem(
                                              value: a,
                                              child: Text(a),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) =>
                                      controller.alcoholConsumption.value =
                                          val ?? '',
                                  decoration: const InputDecoration(
                                    labelText: 'Alcohol Consumption',
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
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: DropdownButtonFormField<String>(
                                  value:
                                      controller.physicalActivity.value.isEmpty
                                      ? null
                                      : controller.physicalActivity.value,
                                  items:
                                      [
                                            'Sedentary',
                                            'Light',
                                            'Moderate',
                                            'Active',
                                          ]
                                          .map(
                                            (p) => DropdownMenuItem(
                                              value: p,
                                              child: Text(p),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) =>
                                      controller.physicalActivity.value =
                                          val ?? '',
                                  decoration: const InputDecoration(
                                    labelText: 'Physical Activity Level',
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
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: controller.preferences.value.isEmpty
                                      ? null
                                      : controller.preferences.value,
                                  items:
                                      [
                                            'None',
                                            'Vegetarian',
                                            'Vegan',
                                            'Gluten-Free',
                                            'Lactose-Free',
                                            'Other',
                                          ]
                                          .map(
                                            (p) => DropdownMenuItem(
                                              value: p,
                                              child: Text(p),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) =>
                                      controller.preferences.value = val ?? '',
                                  decoration: const InputDecoration(
                                    labelText: 'Preferences/Restrictions',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
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
                                      onPressed: controller.goToNextPage,
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

                      // Page 7: Upload Medical Documents/Images
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 60,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.upload_file,
                                  size: 48,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                'Upload X-rays, medication images, doctor diagnoses, or any pertinent files related to your health. In emergencies or as needed, these documents can be reviewed by healthcare professionals with your prior permission for more informed and efficient care.',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(
                              () => Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: List.generate(
                                  controller.uploadedImages.length,
                                  (index) => Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          File(
                                            controller
                                                .uploadedImages[index]
                                                .path,
                                          ),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () =>
                                              controller.removeImage(index),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: controller.pickImages,
                                icon: const Icon(Icons.add_a_photo),
                                label: const Text('Add Images'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryAccentColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                ),
                              ),
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
                                      child: const Text('Complete'),
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
