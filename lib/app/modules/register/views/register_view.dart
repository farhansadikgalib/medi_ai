import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/helper/print_log.dart';
import '../../../../core/style/app_colors.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
          child: GetBuilder<RegisterController>(
            builder: (controller) {
              // Onboarding section
              if (!controller.showAgreement) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 300,
                      child: PageView.builder(
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                controller.images[index],
                                height: 100,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                controller.titles[index],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                controller.subtitles[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.currentPage == index
                                ? AppColors.primaryAccentColor
                                : Colors.white24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryAccentColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          if (controller.currentPage < 2) {
                            controller.pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            controller.showAgreementSection();
                          }
                        },
                        child: Text(
                          controller.currentPage < 2 ? 'Next' : 'Continue',
                        ),
                      ),
                    ),
                  ],
                );
              }
              // Agreement section
              else if (!controller.showUserTypeSelection) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified_user,
                      size: 48,
                      color: AppColors.primaryAccentColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Agreement',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryAccentColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CheckboxListTile(
                      value: controller.agreeTerms,
                      onChanged: (val) => controller.setAgreeTerms(val!),
                      title: const Text(
                        'I agree to the Terms and Conditions',
                        style: TextStyle(color: Colors.black),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primaryAccentColor,
                    ),
                    CheckboxListTile(
                      value: controller.agreePrivacy,
                      onChanged: (val) => controller.setAgreePrivacy(val!),
                      title: const Text(
                        'I agree to the Privacy Policy',
                        style: TextStyle(color: Colors.black),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primaryAccentColor,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryAccentColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: (controller.agreeTerms && controller.agreePrivacy)
                            ? () {
                                controller.showUserTypeSelectionSection();
                              }
                            : null,
                      ),
                    ),
                  ],
                );
              }
              // User type selection section
              else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select User Type',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryAccentColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: UserType.values.map((type) {
                        final label = type == UserType.patient
                            ? 'Patient'
                            : type == UserType.hospital
                                ? 'Hospital'
                                : 'Ambulance';
                        final icon = type == UserType.patient
                            ? FontAwesomeIcons.user
                            : type == UserType.hospital
                                ? FontAwesomeIcons.hospital
                                : FontAwesomeIcons.ambulance;
                        final isSelected = controller.selectedUserType == type;
                        return GestureDetector(
                          onTap: () => controller.selectUserType(type),
                          child: Card(
                            color: isSelected ? AppColors.primaryAccentColor : Colors.white12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: isSelected ? AppColors.primaryAccentColor : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            elevation: isSelected ? 8 : 2,
                            child: Container(
                              width: 100,
                              height: 130,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    icon,
                                    size: 40,
                                    color: isSelected ? Colors.white : Colors.white70,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    label,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.white70,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryAccentColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: controller.selectedUserType != null
                            ? () {
                                // Handle registration continue with selected user type
                                printLog('Continue with user type: ${controller
                                    .selectedUserType}');
                              }
                            : null,
                        child:  Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

