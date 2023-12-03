class ApiConstants {
  // static const String baseUrl = 'http://192.168.1.96:8000/api';

  static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const String apiLogin = '$baseUrl/auth/login';
  static const String apiRegister = '$baseUrl/auth/register';
  static const String apiUserProfile = '$baseUrl/auth/user-profile';
  static const String apiUpdateUser = '$baseUrl/auth/update-profile';

  static const String apiUser = '$baseUrl/users';
  static const String apiBoardingHouse = '$baseUrl/boarding-houses';
}

const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';

class ApiAddress {
  static const String addressUrl = 'https://provinces.open-api.vn/api/p/92';
}

class AppString {
  AppString._();

  static const String google_map_api_key =
      "AIzaSyBNEUDMuDUf5GH6dbcqsRdeg2NYG4yRWA8";
}
