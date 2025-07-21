import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/global_controller.dart';

class GlobalView extends GetView<GlobalController> {
  const GlobalView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GlobalView'), centerTitle: true),
      body: Center(
        child: AnyImageView(
          imagePath:
              'https://cdn.pixabay.com/photo/2023/06/04/20/21/cat-8040862_1280.jpg',
          width: Get.width / 1.10,
        ),
      ),
    );
  }
}
