import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_urls.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/data/model/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiService apiService;

  ProfileRemoteDataSourceImpl({required this.apiService});

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await apiService.get(ApiUrls.customerGetProfile);
      return ProfileModel.fromJson(response);
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
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await apiService.post(
        ApiUrls.customerUpdateProfile,
        data: FormData.fromMap(data),
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
