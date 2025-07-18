import 'package:get/get.dart';
import 'package:medi/app/routes/app_pages.dart';
import 'package:medi/core/helper/shared_value_helper.dart';
import 'package:medi/generated/assets.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  var selectedLanguage = 'en'.obs;

  final List<Map<String, String>> pages = [
    {
      'image': Assets.dashboardIconsL1,
      'title': 'Feature One',
      'subtitle': 'Description of feature one.',
    },
    {
      'image': Assets.categoryIconsDental,
      'title': 'Feature Two',
      'subtitle': 'Description of feature two.',
    },
    {
      'image': Assets.hCi5,
      'title': 'Feature Three',
      'subtitle': 'Description of feature three.',
    },
  ];

  void setLanguage(String lang) {
    selectedLanguage.value = lang;
    // Add language change logic if needed
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      currentPage.value++;
    }
  }

  void finishOnboarding() async {
    // onBoardView.$ = false;
    // onBoardView.save();
    Get.offAllNamed(Routes.LOGIN);
  }
}
