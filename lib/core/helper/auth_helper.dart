
import 'package:medi/core/helper/shared_value_helper.dart';

import '../../data/remote/model/auth/login_response.dart';

class AuthHelper {
  setUserData(
      LoginResponse loginResponse, String getSRCode, String todayLoginTime) {
    if (loginResponse.token != null) {
      isLoggedIn.$ = true;
      isLoggedIn.save();

      accessToken.$ = "Bearer ${loginResponse.token}";
      accessToken.save();

      userName.$ = loginResponse.name!;
      userName.save();


      email.$ = loginResponse.email!;
      email.save();

      isAdmin.$ = loginResponse.isAdmin!;
      isAdmin.save();

      isDriver.$ = loginResponse.isDriver!;
      isDriver.save();

    }
  }

  clearUserData() {
    isLoggedIn.$ = false;
    isLoggedIn.save();

    accessToken.$ = "";
    accessToken.save();


    email.$ = "";
    email.save();

    userName.$ = "";
    userName.save();

    isAdmin.$ = 0;
    isAdmin.save();

    isDriver.$ = 0;
    isDriver.save();
  }

  loadItems() {
    isLoggedIn.load();
    accessToken.load();
    userName.load();
    email.load();
    isAdmin.load();
    isDriver.load();
  }
}
