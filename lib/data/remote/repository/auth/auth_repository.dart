import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';
import '../../model/auth/login_response.dart';
import '../../model/auth/logout_response.dart';

class AuthRepository {
  Future<LoginResponse> getUserLogin(String email, String password) async {
    var response = await ApiClient().post(
      ApiEndPoints.login,
      data: {"email": email, "password": password},
      showLoader: true,
      requiresAuth: false,
    );

    return loginResponseFromJson(response.toString());
  }

  Future<LogoutResponse> getUserLogOut() async {
    var response = await ApiClient().post(
      ApiEndPoints.logout,
      data: {},
      requiresAuth: true,
      showLoader: false,
    );

    return logoutResponseFromJson(response.toString());
  }
}
