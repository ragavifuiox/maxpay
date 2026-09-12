import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/instant_pay_bill_model.dart';
import 'package:maxpay/core/domain/repository/landline_pay_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class LandlinePayRepoImpl implements LandlinePayRepository {
  final ApiService apiService;

  LandlinePayRepoImpl(this.apiService);

  @override
  Future<Either<Failure, InstantPayBill>> payLandlineBill({
    required String productId,
    required String consumerNumber,
    required String amount,
    required String reEnterAmount,
    required String enquiryReference,
    required String customerMobile,
    required String whatsappNumber,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.landlinePay,
        data: {
          'product_id': productId,
          'consumer_number': consumerNumber,
          'amount': amount,
          're_enter_amount': reEnterAmount,
          'enquiry_reference': enquiryReference,
          'customer_mobile': customerMobile,
          'whatsapp_number': whatsappNumber,
        },
      );

      final model = InstantPayBill.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
