import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:medi/core/style/app_colors.dart';
import '../controllers/home_controller.dart';
import 'dart:math';

import '../widget/clay_circle_dashboard.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    final radius = size.width * 0.35;
    final center = Offset(size.width / 2, size.height / 2);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Stack(
          children: [
            // Center profile/logo
            Positioned(
              left: center.dx - 48,
              top: center.dy - 48,
              child: ClayContainer(
                color: AppColors.primaryColor,
                borderRadius: 60,
                depth: 40,
                spread: 8,
                child: SizedBox(
                  width: 96,
                  height: 96,
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 48,
                      color: Color(0xFF185A9D),
                    ),
                  ),
                ),
              ),
            ),
            // Circular dashboard items
            ...List.generate(HomeController.items.length, (i) {
              final angle = (2 * pi / HomeController.items.length) * i - pi / 2;
              final x = center.dx + radius * cos(angle) - 48;
              final y = center.dy + radius * sin(angle) - 48;
              return Positioned(
                left: x,
                top: y,
                child: ClayCircleDashboardCard(
                  item: HomeController.items[i],
                  baseColor: AppColors.primaryColor,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
