// import 'package:dartz/dartz.dart';
// import 'package:maxpay/core/constants/api_routes.dart';
// import 'package:maxpay/core/data/model/wallet_balance.dart';
// import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
// import 'package:maxpay/core/error/failure.dart';
// import 'package:maxpay/core/services/api_services.dart';


// class WalletBalanceRepoImpl implements WalletBalanceRepository {
//   final ApiService apiService;
//   WalletBalanceRepoImpl(this.apiService);

//   @override
//   Future<Either<Failure, WalletBalance>> getWalletBalance() async {
//     try {
//       final response = await apiService.get(ApiRoutes.walletbalance);
//       final model = WalletBalance.fromJson(response);
//       return Right(model);
//     } catch (e) {
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }
// }



import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/wallet_balance.dart';
import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class WalletBalanceRepoImpl implements WalletBalanceRepository {
  final ApiService apiService;

  WalletBalanceRepoImpl(this.apiService);

  @override
  Future<Either<Failure, WalletBalance>> getWalletBalance() async {
    try {
      final response = await apiService.get(ApiRoutes.walletbalance);
      final model = WalletBalance.fromJson(response);
      return Right(model);
    } on DioException catch (e) {
      String message = "Something went wrong";

      if (e.response?.data is Map<String, dynamic>) {
        message = e.response?.data["message"] ?? message;
      } else if (e.response?.data != null) {
        message = e.response!.data.toString();
      } else {
        message = e.message ?? message;
      }

      print("STATUS CODE : ${e.response?.statusCode}");
      print("ERROR DATA  : ${e.response?.data}");
      print("MESSAGE     : $message");

      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}