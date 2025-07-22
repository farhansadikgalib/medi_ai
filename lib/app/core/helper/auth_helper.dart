import 'package:medi/app/core/helper/shared_value_helper.dart';

import '../../remote/model/auth/login_response.dart';

class AuthHelper {
   setUserData(
    LoginResponse loginResponse,
    String todayLoginTime,
  ) {
    if (loginResponse.token != null) {
      isLoggedIn.$ = true;
      isLoggedIn.save();

      accessToken.$ = "Bearer ${loginResponse.token}";
      accessToken.save();

      userName.$ = loginResponse.data!.owner!;
      userName.save();

      email.$ = loginResponse.data!.email!;
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
