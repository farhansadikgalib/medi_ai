import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/patient_registration_controller.dart';

class PatientRegistrationView extends GetView<PatientRegistrationController> {
  const PatientRegistrationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PatientRegistrationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PatientRegistrationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
