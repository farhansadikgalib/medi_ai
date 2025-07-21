import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hospital_registration_controller.dart';

class HospitalRegistrationView extends GetView<HospitalRegistrationController> {
  const HospitalRegistrationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HospitalRegistrationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HospitalRegistrationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
