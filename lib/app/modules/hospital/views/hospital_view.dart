import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hospital_controller.dart';

class HospitalView extends GetView<HospitalController> {
  const HospitalView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HospitalView'), centerTitle: true),
      body: const Center(
        child: Text('HospitalView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
