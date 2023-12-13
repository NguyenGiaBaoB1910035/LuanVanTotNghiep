class ApiConstants {
  // static const String baseUrl = 'http://192.168.127.149:8000/api';

  static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const String apiLogin = '$baseUrl/auth/login';
  static const String apiRegister = '$baseUrl/auth/register';
  // static const String apiUserProfile = '$baseUrl/auth/user-profile';
  // static const String apiUpdateUser = '$baseUrl/auth/update-profile';
  // static const String apiUser = '$baseUrl/users';
  // static const String apiBoardingHouse = '$baseUrl/boarding-houses';

  // static const String apiUtil = '$baseUrl/...';
  // static const String apiBoardingHouseType = '$baseUrl/...';
  // static const String apiPost = '$baseUrl/...';
  // static const String apiEvaluate = '$baseUrl/...';
}

const baseUrl = 'http://10.0.2.2:8000/api';
// const baseUrl = 'http://192.168.127.149:8000/api';

const apiLogin = baseUrl + '/auth/login';
const apiRegister = baseUrl + '/auth/register';
const apiUser = baseUrl + '/users';
const apiBoardingHouse = baseUrl + '/boarding-houses';
const apiBoardingHouseType = baseUrl + '/boarding-house-types';
const apiUtil = baseUrl + '/utils';
const apiPost = baseUrl + '/posts';
const apiEvaluate = baseUrl + '/evaluates';

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
