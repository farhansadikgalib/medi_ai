import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/generated/assets.dart';

    class RegisterController extends GetxController {
      final pageController = PageController();
      var currentPage = 0;

      final titles = [
        'Welcome',
        'Discover',
        'Connect',
        'Learn',
        'Grow',
        'Get Started',
      ];

      final subtitles = [
        'Start your journey',
        'Find new features',
        'Meet new people',
        'Expand your knowledge',
        'Achieve your goals',
        'Let\'s begin!',
      ];

      final images = [
        Assets.iconsIcHospital,
        Assets.iconsIcHospital,
        Assets.iconsIcHospital,
        Assets.iconsIcHospital,
        Assets.iconsIcHospital,
        Assets.iconsIcHospital,

      ];

      final descriptions = [
        'Welcome to our app! Experience a new way to manage your tasks.',
        'Discover amazing features designed to boost your productivity.',
        'Connect with like-minded individuals and grow your network.',
        'Learn from the best resources and improve your skills.',
        'Grow with us and reach new heights in your journey.',
        'Ready to get started? Let\'s dive in!',
      ];

      void onPageChanged(int index) {
        currentPage = index;
        update();
      }
    }