import 'package:get/get.dart';

import '../modules/ambulance/bindings/ambulance_binding.dart';
import '../modules/ambulance/views/ambulance_view.dart';
import '../modules/doctor/bindings/doctor_binding.dart';
import '../modules/doctor/views/doctor_view.dart';
import '../modules/global/bindings/global_binding.dart';
import '../modules/global/views/global_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/hospital/bindings/hospital_binding.dart';
import '../modules/hospital/views/hospital_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/patient/bindings/patient_binding.dart';
import '../modules/patient/views/patient_view.dart';
import '../modules/patient_registration/bindings/patient_registration_binding.dart';
import '../modules/patient_registration/views/patient_registration_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: _Paths.GLOBAL,
      page: () => const GlobalView(),
      binding: GlobalBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOSPITAL,
      page: () => const HospitalView(),
      binding: HospitalBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR,
      page: () => const DoctorView(),
      binding: DoctorBinding(),
    ),
    GetPage(
      name: _Paths.AMBULANCE,
      page: () => const AmbulanceView(),
      binding: AmbulanceBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT,
      page: () => const PatientView(),
      binding: PatientBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_REGISTRATION,
      page: () => const PatientRegistrationView(),
      binding: PatientRegistrationBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
  ];
}
