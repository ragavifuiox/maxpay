

// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:maxpay/core/constants/api_routes.dart';
// import 'package:maxpay/core/data/model/wallet_transfer_model.dart';
// import 'package:maxpay/core/domain/repository/wallet_transfer_repository.dart';
// import 'package:maxpay/core/error/failure.dart';
// import 'package:maxpay/core/services/api_services.dart';

// class WalletTransferRepoImpl implements WalletTransferRepository {
//   final ApiService apiService;

//   WalletTransferRepoImpl(this.apiService);

 

// @override
// Future<Either<Failure, walletTransfer>> walletransfer({
//   required String staffid,
//   required String paymenttype,
//   required String amount,
  
// }) async {
//   try {

//     final formData = FormData.fromMap({
//       "staff_id": staffid,
//       "payment_type": paymenttype,
//       "amount": amount,
    

//       // 🔥 THIS IS THE FIX
      
//     });
// print("😂staff_id: $staffid");
// print("payment_type: $paymenttype");
// print("amount: $amount");
//     final response = await apiService.post(
//       ApiRoutes.wallettransfer,
//       data: formData,
//     );

//     final model = walletTransfer.fromJson(response);
//     return Right(model);

//   } catch (e) {
//     return Left(ServerFailure(message: e.toString()));
//   }
// }}



import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/wallet_transfer_model.dart';
import 'package:maxpay/core/domain/repository/wallet_transfer_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class WalletTransferRepoImpl implements WalletTransferRepository {
  final ApiService apiService;

  WalletTransferRepoImpl(this.apiService);

  @override
  Future<Either<Failure, walletTransfer>> walletransfer({
    required String staffid,
    required String paymenttype,
    required String amount,
  }) async {
    try {
      final formData = FormData.fromMap({
        "staff_id": staffid,
        "payment_type": paymenttype,
        "amount": amount,
      });

      print("staff_id: $staffid");
      print("payment_type: $paymenttype");
      print("amount: $amount");

      final response = await apiService.post(
        ApiRoutes.wallettransfer,
        data: formData,
      );

      final model = walletTransfer.fromJson(response);

      return Right(model);

    } on DioException catch (e) {
      return Left(DioErrorHandler.handle(e));
    } catch (e) {
      return Left(
        ServerFailure(message: e.toString()),
      );
    }
  }
}