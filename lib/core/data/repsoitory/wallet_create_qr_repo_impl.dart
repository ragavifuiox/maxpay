import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/wallet_create_qr_model.dart';
import 'package:maxpay/core/data/model/wallet_qr_history.dart';
import 'package:maxpay/core/domain/repository/wallet_create_qr_repo.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class WalletCreateQrRepoImpl implements WalletCreateQrRepo {
  final ApiService apiService;

  WalletCreateQrRepoImpl(this.apiService);



  @override
  Future<Either<Failure, CreateQrResponse>> createQr({
    required String amount,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.createQr,
        data: {'amount': amount},
      );
      AppLogger.logError(response);

      final responseData = CreateQrResponse.fromJson(response);

      if (responseData.status == true) {
        return Right(responseData);
      } else {
        return Left(ServerFailure(message: responseData.status.toString()));
      }
    } catch (e, stackTrace) {
      print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> checkQrStatus({required String txnId}) async {
    try {
      final response = await apiService.post(
        ApiRoutes.checkQr,
        data: {'txn_id': txnId},
      );

      final responseData = response['status'];

      return Right(responseData);
    } catch (e, stackTrace) {
      print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WalletQrHistory>> getWalletHistory() async {
    try {
      final response = await apiService.get(ApiRoutes.walletQrHistory);

      final responseData = WalletQrHistory.fromJson(response);

      if (responseData.success == true) {
        return Right(responseData);
      } else {
        return Left(UnexpectedFailure(responseData.message ?? ''));
      }
    } catch (e, stackTrace) {
      print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}