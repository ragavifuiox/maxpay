import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/wallet_create_qr_model.dart';
import 'package:maxpay/core/data/model/wallet_qr_history.dart';
import 'package:maxpay/core/domain/repository/wallet_create_qr_repo.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

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

      final responseData = CreateQrResponse.fromJson(response);

      if (responseData.status == true) {
        if (responseData.upiLink != null) {
          return Right(responseData);
        } else {
          return Left(ServerFailure(message: "Url Not found"));
        }
      } else {
        return Left(ServerFailure(message: responseData.status.toString()));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
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
    } catch (e) {
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
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
