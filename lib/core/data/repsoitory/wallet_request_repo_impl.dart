

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/wallet_request_model.dart';
import 'package:maxpay/core/domain/repository/wallet_request_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class WalletRequestRepoImpl implements WalletRequestRepository {
  final ApiService apiService;

  WalletRequestRepoImpl(this.apiService);

 

@override
Future<Either<Failure, WalletRequest>> walletRequest({
  required String amount,
  required String paymenttype,
  required String utrno,
  required String bankid,
  required String description,
  required String receipt,
}) async {
  try {

    final formData = FormData.fromMap({
      "amount": amount,
      "payment_type": paymenttype,
      "utr_no": utrno,
      "bank_id": bankid,
      "description": description,

      // 🔥 THIS IS THE FIX
      "receipt": await MultipartFile.fromFile(
        receipt,
        filename: "receipt.jpg",
      ),
    });

    final response = await apiService.post(
      ApiRoutes.walletrequest,
      data: formData,
    );

    final model = WalletRequest.fromJson(response);
    return Right(model);

  } catch (e) {
    return Left(ServerFailure(message: e.toString()));
  }
}}
