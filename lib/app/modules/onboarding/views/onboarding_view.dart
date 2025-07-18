import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clay_containers/clay_containers.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  OnboardingView({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => controller.currentPage.value = index,
                itemCount: controller.pages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Language selection page
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 60),
                            const Text(
                              'Welcome!',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Select your preferred language to continue.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 48),
                            // Only DropdownButton uses observable
                            ClayContainer(
                              color: Colors.white,
                              borderRadius: 16,
                              depth: 20,
                              spread: 4,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: Obx(
                                    () => DropdownButton<String>(
                                      value: controller.selectedLanguage.value,
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'en',
                                          child: Text('English'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'bn',
                                          child: Text('Bangla'),
                                        ),
                                      ],
                                      onChanged: (val) {
                                        if (val != null) {
                                          controller.setLanguage(val);
                                        }
                                      },
                                      isExpanded: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
                            // Only Row uses observable
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  controller.pages.length + 1,
                                  (i) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: controller.currentPage.value == i
                                          ? Colors.blueAccent
                                          : Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    final page = controller.pages[index - 1];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 40),
                            if (index < controller.pages.length)
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                  onPressed: controller.finishOnboarding,
                                  child: const Text(
                                    'Skip',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 20),
                            ClayContainer(
                              color: Colors.white,
                              borderRadius: 24,
                              depth: 40,
                              spread: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Image.asset(
                                  page['image']!,
                                  height: 200,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              page['title']!,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              page['subtitle']!,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            // Only Row uses observable
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  controller.pages.length + 1,
                                  (i) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: controller.currentPage.value == i
                                          ? Colors.blueAccent
                                          : Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),


            SizedBox(
              width: Get.width/1.5,
              height: 50,
              child:ElevatedButton(
                onPressed: () {
                  if (controller.currentPage.value <
                      controller.pages.length) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease,
                    );
                  } else {
                    controller.finishOnboarding();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Next'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
