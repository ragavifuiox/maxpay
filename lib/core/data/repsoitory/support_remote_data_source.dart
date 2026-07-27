import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_urls.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/data/model/support_model.dart';

abstract class SupportRemoteDataSource {
  Future<SupportModel> getSupport();
}

class SupportRemoteDataSourceImpl implements SupportRemoteDataSource {
  final ApiService apiService;

  SupportRemoteDataSourceImpl({required this.apiService});

  @override
  Future<SupportModel> getSupport() async {
    try {
      final response = await apiService.get(ApiUrls.customerGetSupport);
      return SupportModel.fromJson(response);
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
