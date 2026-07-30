// import 'package:dartz/dartz.dart';
// import 'package:maxpay/core/constants/api_routes.dart';
// import 'package:maxpay/core/data/model/transaction_suc_faii_model.dart';
// import 'package:maxpay/core/domain/repository/transaction_suc_fail_repository.dart';
// import 'package:maxpay/core/error/failure.dart';
// import 'package:maxpay/core/services/api_services.dart';


// class TransactionSucFailRepoImpl implements TransactionSucFailRepository {
//   final ApiService apiService;
//   TransactionSucFailRepoImpl(this.apiService);

//   @override
//   Future<Either<Failure, TransactionResponse>> getrans() async {
//     try {
//       final response = await apiService.get(ApiRoutes.transsucfail);
//       final model = TransactionResponse.fromJson(response);
//       return Right(model);
//     } catch (e) {
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }
// }


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/transaction_suc_faii_model.dart';
import 'package:maxpay/core/domain/repository/transaction_suc_fail_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class TransactionSucFailRepoImpl implements TransactionSucFailRepository {
  final ApiService apiService;

  TransactionSucFailRepoImpl(this.apiService);

  @override
  Future<Either<Failure, TransactionResponse>> getrans() async {
    try {
      final response = await apiService.get(ApiRoutes.transsucfail);
      final model = TransactionResponse.fromJson(response);
      return Right(model);
    } on DioException catch (e) {
      return Left(DioErrorHandler.handle(e));
    } catch (e) {
      AppLogger.logError("Api ${ApiRoutes.transsucfail}$e");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}