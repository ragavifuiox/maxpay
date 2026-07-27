import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_urls.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/data/model/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel> sendOtp(String countryCode, String phoneNumber);
  Future<LoginModel> verifyOtp(String phoneNumber, String otp);
  Future<LoginModel> createPin(String pin);
  Future<LoginModel> verifyPin(String pin);
  Future<LoginModel> signupSendOtp(String countryCode, String phoneNumber, String name, String pincode);
  Future<Map<String, dynamic>> logout();
  Future<Map<String, dynamic>> updateFingerprint(int status);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiService apiService;

  LoginRemoteDataSourceImpl({required this.apiService});

  @override
  Future<LoginModel> sendOtp(String countryCode, String phoneNumber) async {
    try {
      final formData = FormData.fromMap({
        'country_code': countryCode,
        'phone_number': phoneNumber,
      });

      final response = await apiService.post(
        ApiUrls.customerLoginSendOtp,
        data: formData,
      );

      return LoginModel.fromJson(response);
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map && e.response?.data['message'] != null
          ? e.response?.data['message']
          : e.message;
      throw Exception(errorMessage ?? 'Unknown error occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<LoginModel> verifyOtp(String phoneNumber, String otp) async {
    try {
      final formData = FormData.fromMap({
        'phone_number': phoneNumber,
        'otp': otp,
      });

      final response = await apiService.post(
        ApiUrls.customerLoginVerifyOtp,
        data: formData,
      );

      return LoginModel.fromJson(response);
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map && e.response?.data['message'] != null
          ? e.response?.data['message']
          : e.message;
      throw Exception(errorMessage ?? 'Unknown error occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<LoginModel> createPin(String pin) async {
    try {
      final formData = FormData.fromMap({
        'pin': pin,
      });

      final response = await apiService.post(
        ApiUrls.customerCreatePin,
        data: formData,
      );

      return LoginModel.fromJson(response);
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map && e.response?.data['message'] != null
          ? e.response?.data['message']
          : e.message;
      throw Exception(errorMessage ?? 'Unknown error occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<LoginModel> verifyPin(String pin) async {
    try {
      final formData = FormData.fromMap({
        'pin': pin,
      });

      final response = await apiService.post(
        ApiUrls.customerVerifyPin,
        data: formData,
      );

      return LoginModel.fromJson(response);
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map && e.response?.data['message'] != null
          ? e.response?.data['message']
          : e.message;
      throw Exception(errorMessage ?? 'Unknown error occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<LoginModel> signupSendOtp(String countryCode, String phoneNumber, String name, String pincode) async {
    try {
      final formData = FormData.fromMap({
        'country_code': countryCode,
        'phone_number': phoneNumber,
        'name': name,
        'pincode': pincode,
      });

      final response = await apiService.post(
        ApiUrls.customerSignupSendOtp,
        data: formData,
      );

      return LoginModel.fromJson(response);
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map && e.response?.data['message'] != null
          ? e.response?.data['message']
          : e.message;
      throw Exception(errorMessage ?? 'Unknown error occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await apiService.post(ApiUrls.customerLogout);
      return response;
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map && e.response?.data['message'] != null
          ? e.response?.data['message']
          : e.message;
      throw Exception(errorMessage ?? 'Unknown error occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> updateFingerprint(int status) async {
    try {
      final response = await apiService.post(
        ApiUrls.customerUpdateFingerprint,
        data: {'is_finger_print': status.toString()},
      );
      return response;
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map && e.response?.data['message'] != null
          ? e.response?.data['message']
          : e.message;
      throw Exception(errorMessage ?? 'Unknown error occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
