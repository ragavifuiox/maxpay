import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/instant_pay_bill_model.dart';
import 'package:maxpay/core/domain/repository/electricity_pay_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class ElectricityPayRepoImpl implements ElectricityPayRepository {
  final ApiService apiService;

  ElectricityPayRepoImpl(this.apiService);

  @override
  Future<Either<Failure, InstantPayBill>> electricityPayTransaction({
    required String productId,
    required String consumerNumber,
    required String amount,
    required String reEnterAmount,
    required String enquiryReference,
    required String customerMobile,
    required String whatsappNumber,
  }) async {
    try {
      final payload = {
        'product_id': productId,
        'consumer_number': consumerNumber,
        'amount': amount,
        're_enter_amount': reEnterAmount,
        'enquiry_reference': enquiryReference,
        'customer_mobile': customerMobile,
        'whatsapp_number': whatsappNumber,
      };
      print("===== ELECTRICITY PAY PAYLOAD =====");
      print(payload);

      final response = await apiService.post(
        ApiRoutes.electricityPay,
        data: payload,
      );

      print("===== ELECTRICITY PAY RESPONSE =====");
      print(response);

      final decoded = response;
      Map<String, dynamic> jsonMap;

      if (decoded is List) {
        jsonMap = decoded.isNotEmpty ? Map<String, dynamic>.from(decoded) : {};
      } else {
        jsonMap = decoded;
      }

      final model = InstantPayBill.fromJson(jsonMap);
      return Right(model);
    } catch (e, stackTrace) {
      print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
