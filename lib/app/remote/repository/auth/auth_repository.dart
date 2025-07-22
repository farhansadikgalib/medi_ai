import 'package:medi/app/remote/model/auth/login_response.dart';
import 'package:medi/app/remote/model/auth/register_response.dart';

import '../../../network_service/api_client.dart';
import '../../../network_service/api_end_points.dart';

class AuthRepository {
  Future<LoginResponse> getSignIn(String email, String password) async {
    var response = await ApiClient().post(
      ApiEndPoints.login,
      {"email": email, "password": password},
      getSignIn,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );

    return safeFromJson(
      response,
      (json) => LoginResponse.fromJson(json),
      LoginResponse(),
    );
  }


  Future<RegisterResponse> getRegister(String phone, String email, String
  password)
  async {
    var response = await ApiClient().post(
      ApiEndPoints.register,
      {"email": email,'phone':phone, "password": password},
      getSignIn,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );

    return safeFromJson(
      response,
      (json) => registerResponseFromJson(json.toString()),
      RegisterResponse(),
    );
  }
}
