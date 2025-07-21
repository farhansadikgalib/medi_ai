import 'package:medi/app/modules/hospital_registration/model/operating_hours_entry.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/core/style/app_colors.dart';

import '../controllers/hospital_registration_controller.dart';
import 'dart:io';

class HospitalRegistrationView extends GetView<HospitalRegistrationController> {
  const HospitalRegistrationView({super.key});
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
          child: GetBuilder<HospitalRegistrationController>(
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
                                  Icons.local_hospital,
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
                      // Page 2: Select Hospital/Clinic
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            AppWidgets().gapH24(),
                            Text(
                              'Select Facility Type',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryAccentColor,
                              ),
                            ),
                            AppWidgets().gapH24(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildTypeSelector(
                                  controller,
                                  'Hospital',
                                  Icons.local_hospital,
                                ),
                                _buildTypeSelector(
                                  controller,
                                  'Clinic',
                                  Icons.medical_services,
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
                      // Page 3: Facility Details
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            AppWidgets().gapH24(),
                            Text(
                              'Facility Details',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryAccentColor,
                              ),
                            ),
                            AppWidgets().gapH24(),
                            _buildTextField(controller.nameController, 'Name'),
                            _buildPhoneField(
                              controller.dayPhoneController,
                              controller.dayPhoneCountryCode,
                              'Day Phone Number',
                            ),
                            _buildTextField(
                              controller.locationController,
                              'Location',
                            ),
                            _buildPhoneField(
                              controller.nightPhoneController,
                              controller.nightPhoneCountryCode,
                              'Night Phone Number',
                            ),
                            _buildTextField(
                              controller.emailPage3Controller,
                              'Email',
                            ),
                            _buildTextField(
                              controller.countryPage3Controller,
                              'Country',
                            ),
                            _buildTextField(
                              controller.addressController,
                              'Address',
                            ),
                            _buildTextField(controller.cityController, 'City'),
                            _buildTextField(
                              controller.postcodeController,
                              'Postcode',
                            ),
                            _buildTextField(
                              controller.currencyController,
                              'Currency',
                            ),
                            _buildTextField(
                              controller.consumptionTaxController,
                              'Consumption Tax (%)',
                            ),
                            _buildTextField(
                              controller.buildingNameController,
                              'Building Name',
                            ),
                            _buildTextField(
                              controller.numberOfRoomsController,
                              'Number of Rooms',
                            ),
                            _buildTextField(
                              controller.websiteUrlController,
                              'Website URL',
                            ),
                            AppWidgets().gapH16(),
                            _buildCheckbox(controller.hasParking, 'Parking'),
                            _buildCheckbox(
                              controller.isWheelchairAccessible,
                              'Wheelchair Accessible',
                            ),
                            _buildCheckbox(
                              controller.hasWheelchairToilet,
                              'Wheelchair Toilet',
                            ),
                            _buildCheckbox(
                              controller.hasVisualSupport,
                              'Visually Impaired Support',
                            ),
                            _buildCheckbox(
                              controller.hasHearingSupport,
                              'Hearing Impairments Support',
                            ),
                            _buildCheckbox(
                              controller.hasForeignLanguageSupport,
                              'Foreign Language Support',
                            ),
                            const SizedBox(height: 32),
                            _buildDepartmentSection(controller),
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

                      // Page 4: Upload Documents/Images
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
                                'Upload hospital/clinic registration documents, licenses, certifications, or any other relevant documentation. These documents will be reviewed during the verification process to ensure compliance with healthcare regulations.',
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
                                      GestureDetector(
                                        onTap: () =>
                                            controller.removeImage(index),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
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
                              child: InkWell(
                                onTap: controller.pickImages,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.cloud_upload,
                                        size: 48,
                                        color: AppColors.primaryAccentColor,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Upload Documents',
                                        style: TextStyle(
                                          color: AppColors.primaryAccentColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
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
                                      child: const Text('Submit'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Page 5: Opening Hours
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First Opening and Closing Hours:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryAccentColor,
                              ),
                            ),
                            AppWidgets().gapH16(),
                            ...controller.firstOpeningHours.map(
                              (entry) => _buildOperatingHoursRow(
                                controller,
                                entry,
                                context,
                              ),
                            ),
                            AppWidgets().gapH24(),
                            Text(
                              'Second Opening and Closing Hours:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryAccentColor,
                              ),
                            ),
                            AppWidgets().gapH16(),
                            ...controller.secondOpeningHours.map(
                              (entry) => _buildOperatingHoursRow(
                                controller,
                                entry,
                                context,
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
                                      child: const Text('Submit'),
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

  Widget _buildOperatingHoursRow(
    HospitalRegistrationController controller,
    OperatingHoursEntry entry,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(entry.day)),
          Expanded(
            flex: 1,
            child: Obx(
              () => Switch(
                value: entry.isOpen.value,
                onChanged: (val) => entry.isOpen.value = val,
                activeColor: AppColors.primaryAccentColor,
              ),
            ),
          ),
          Obx(
            () => entry.isOpen.value
                ? Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        _buildTimePicker(context, controller, entry.openTime),
                        const Text(' To '),
                        _buildTimePicker(context, controller, entry.closeTime),
                      ],
                    ),
                  )
                : const Spacer(flex: 4),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker(
    BuildContext context,
    HospitalRegistrationController controller,
    Rx<TimeOfDay?> time,
  ) {
    return InkWell(
      onTap: () => controller.pickTime(context, time),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Obx(() => Text(time.value?.format(context) ?? 'Select')),
      ),
    );
  }

  Widget _buildDepartmentSection(HospitalRegistrationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Departments',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryAccentColor,
          ),
        ),
        AppWidgets().gapH16(),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.departments
              .map(
                (d) => Obx(
                  () => ActionChip(
                    label: Text(d),
                    backgroundColor: controller.selectedDepartment.value == d
                        ? AppColors.primaryAccentColor
                        : Colors.grey[300],
                    labelStyle: TextStyle(
                      color: controller.selectedDepartment.value == d
                          ? Colors.white
                          : Colors.black,
                    ),
                    onPressed: () => controller.selectDepartment(d),
                  ),
                ),
              )
              .toList(),
        ),
        Obx(() {
          if (controller.selectedDepartment.value.isEmpty) {
            return const SizedBox.shrink();
          }
          final subSpecialties =
              controller.subSpecialties[controller.selectedDepartment.value] ??
              [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppWidgets().gapH16(),
              Text(
                'Sub-specialties for ${controller.selectedDepartment.value}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryAccentColor,
                ),
              ),
              ...subSpecialties
                  .map(
                    (s) => Obx(
                      () => CheckboxListTile(
                        title: Text(s),
                        value: controller.subSpecialtyStates[s] ?? false,
                        onChanged: (val) =>
                            controller.toggleSubSpecialty(s, val),
                        activeColor: AppColors.primaryAccentColor,
                      ),
                    ),
                  )
                  .toList(),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClayContainer(
        depth: 16,
        spread: 2,
        color: AppColors.primaryColor,
        borderRadius: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField(
    TextEditingController controller,
    RxString countryCode,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClayContainer(
            depth: 16,
            spread: 2,
            color: AppColors.primaryColor,
            borderRadius: 8,
            child: CountryCodePicker(
              onChanged: (country) =>
                  countryCode.value = country.dialCode ?? '',
              initialSelection: countryCode.value.isNotEmpty
                  ? countryCode.value
                  : '+1',
              favorite: const ['+1', '+91'],
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
              textStyle: const TextStyle(color: Colors.black),
              padding: const EdgeInsets.symmetric(horizontal: 12),
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
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: label,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(RxBool controller, String title) {
    return Obx(
      () => ClayContainer(
        depth: 16,
        spread: 2,
        color: AppColors.primaryColor,
        borderRadius: 8,
        child: CheckboxListTile(
          title: Text(title),
          value: controller.value,
          onChanged: (val) => controller.value = val ?? false,
          activeColor: AppColors.primaryAccentColor,
        ),
      ),
    );
  }

  Widget _buildTypeSelector(
    HospitalRegistrationController controller,
    String type,
    IconData icon,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.selectType(type),
        child: ClayContainer(
          width: Get.width / 2.8,
          height: Get.width / 2.8,
          color: controller.selectedType.value == type
              ? AppColors.primaryAccentColor.withOpacity(0.2)
              : AppColors.primaryColor,
          borderRadius: 16,
          depth: controller.selectedType.value == type ? 0 : 12,
          spread: controller.selectedType.value == type ? 0 : 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: AppColors.primaryAccentColor),
              const SizedBox(height: 12),
              Text(
                type,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryAccentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
