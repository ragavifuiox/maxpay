import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_urls.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/data/model/wallet_balance_model.dart';

abstract class WalletRemoteDataSource {
  Future<WalletBalanceModel> getWalletBalance();
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final ApiService apiService;

  WalletRemoteDataSourceImpl({required this.apiService});

  @override
  Future<WalletBalanceModel> getWalletBalance() async {
    try {
      final response = await apiService.get(ApiUrls.customerGetWalletBalance);
      return WalletBalanceModel.fromJson(response);
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
