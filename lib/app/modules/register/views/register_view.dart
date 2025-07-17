        import 'package:any_image_view/any_image_view.dart';
        import 'package:flutter/material.dart';
        import 'package:clay_containers/clay_containers.dart';
        import 'package:get/get.dart';
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
                    builder: (controller) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 260,
                          child: PageView.builder(
                            controller: controller.pageController,
                            itemCount: controller.titles.length,
                            onPageChanged: controller.onPageChanged,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 60,
                                    depth: 30,
                                    spread: 6,
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Center(
                                        child: AnyImageView(
                                          imagePath: controller.images[index],
                                          height: 60,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
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
                                  const SizedBox(height: 8),
                                  Text(
                                    controller.subtitles[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.primaryAccentColor.withOpacity(0.8),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    controller.descriptions[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.primaryAccentColor.withOpacity(0.7),
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
                          children: List.generate(controller.titles.length, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 12),
                              width: controller.currentPage == index ? 14 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: controller.currentPage == index
                                    ? AppColors.primaryAccentColor
                                    : AppColors.primaryAccentColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          }),
                        ),
                        if (controller.currentPage == controller.titles.length - 1)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: SizedBox(
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
                                  // Navigate to main app or registration form
                                },
                                child: const Text('Get Started'),
                              ),
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