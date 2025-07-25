import 'package:get/get.dart';
import '../../modules/home/bindings/home_binding.dart';
import '../connection_manager/connection_manager_binding.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    ConnectionManagerBinding().dependencies();
    // AirportSearchBinding().dependencies();
    // CalenderPickerBinding().dependencies();
    HomeBinding().dependencies();
  }
}
