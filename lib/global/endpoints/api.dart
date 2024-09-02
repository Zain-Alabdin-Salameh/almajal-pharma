import '../utils/config.dart';

class ApiendPoints {
  static String root = '${AppConfig.baseUrl}/';
  static String baseApi = '${root}api/';
  static String getUser = '${baseApi}profile-info';
  static String updateUser = '${baseApi}update-account-setting';
  static String changePass = '${baseApi}update-password';
  static String logout = '${baseApi}logout';
  static String login = '${baseApi}login';
  static String signup = '${baseApi}register';
  static String products = '${baseApi}products';
  static String distributers = '${baseApi}dealers';
  static String categories = '${baseApi}categories';
  static String veiwCart = '${baseApi}cart/view';
  static String addToCart = '${baseApi}cart/add';
  static String removeToCart = '${baseApi}cart/remove/';
  static String updateCart = '${baseApi}cart/update/';
  static String clearCart = '${baseApi}cart/clear';
  static String prodictsByDist = '${baseApi}dealers/show/';
  static String prodictsByCat = '${baseApi}categories/show/';
  static String filter = '${baseApi}filter-products';
  static String order = '${baseApi}order';
  static String getorders = '${baseApi}orders';
  static String sliders = '${baseApi}sliders';
}
