import 'package:clay_containers/widgets/clay_container.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/core/style/app_colors.dart';

import '../controllers/hospital_registration_controller.dart';

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
                                      onPressed: () {
                                        // TODO: Handle next
                                      },
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
