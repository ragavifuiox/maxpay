import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/broadband_confirm_model.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/data/model/instant_pay_bill_model.dart';
import 'package:maxpay/core/domain/repository/broadband_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class BroadbandBillRepoImpl implements BroadbandBillRepository {
  final ApiService apiService;

  BroadbandBillRepoImpl(this.apiService);

  @override
  Future<Either<Failure, InstantPay>> broadbandbill({
    required String productId,
    required String consumerNumber,
  }) async {
    try {
      final formData = FormData.fromMap({
        "product_id": productId,
        "consumer_number": consumerNumber,
      });

      final response = await apiService.post(
        ApiRoutes.broadbandbill,
        data: formData,
      );
      print("BROADBAND FETCH BILL API RESPONSE: $response");
      final model = InstantPay.fromJson(response);
      return Right(model);
    } on DioException catch (e, stackTrace) {
      print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, BroadbandConfirmModel>> confirmTransaction({
    required String productId,
  }) async {
    try {
      final response = await apiService.get(
        "${ApiRoutes.broadbandConfirm}$productId",
      );
      print("BROADBAND CONFIRM API RESPONSE: $response");
      final model = BroadbandConfirmModel.fromJson(response);
      return Right(model);
    } on DioException catch (e, stackTrace) {
      print("API EXCEPTION IN REPO CONFIRM: `$e\n`$stackTrace");
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, InstantPayBill>> payTransaction({
    required String productId,
    required String consumerNumber,
    required String amount,
    required String reEnterAmount,
    required String enquiryReference,
    required String customerMobile,
    required String whatsappNumber,
  }) async {
    try {
      final formData = FormData.fromMap({
        'product_id': productId,
        'consumer_number': consumerNumber,
        'amount': amount,
        're_enter_amount': reEnterAmount,
        'enquiry_reference': enquiryReference,
        'customer_mobile': customerMobile,
        'whatsapp_number': whatsappNumber,
      });

      final response = await apiService.post(
        ApiRoutes.broadbandPay,
        data: formData,
      );
      print("BROADBAND PAY API RESPONSE: $response");
      final model = InstantPayBill.fromJson(response);
      return Right(model);
    } on DioException catch (e, stackTrace) {
      print("API EXCEPTION IN REPO PAY: `$e\n`$stackTrace");
      return Left(DioErrorHandler.handle(e));
    }
  }
}
