import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/payment_product_model.dart';
import 'package:maxpay/core/domain/repository/payment_status_type_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class CashbackTypeRepoImpl implements CashbackTypeRepository {
  final ApiService apiService;
  CashbackTypeRepoImpl(this.apiService);

  @override
  Future<Either<Failure,CashbackProductType >> getpaymentproducttype() async {
    try {
      final response = await apiService.get(ApiRoutes.paymentstatustype);
      final model = CashbackProductType.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

