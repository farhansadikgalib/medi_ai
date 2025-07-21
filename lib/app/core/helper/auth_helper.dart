import 'package:medi/app/core/helper/shared_value_helper.dart';

import '../../remote/model/auth/login_response.dart';

class AuthHelper {
  void setUserData(
    LoginResponse loginResponse,
    String getSRCode,
    String todayLoginTime,
  ) {
    if (loginResponse.token != null) {
      isLoggedIn.$ = true;
      isLoggedIn.save();

      accessToken.$ = "Bearer ${loginResponse.token}";
      accessToken.save();

      userName.$ = loginResponse.name!;
      userName.save();

      email.$ = loginResponse.email!;
      email.save();
    }
  }

  void clearUserData() {
    isLoggedIn.$ = false;
    isLoggedIn.save();

    accessToken.$ = "";
    accessToken.save();

    email.$ = "";
    email.save();

    userName.$ = "";
    userName.save();
  }

  void loadItems() {
    onBoardView.load();
    isLoggedIn.load();
    accessToken.load();
    userName.load();
    email.load();
  }
}
