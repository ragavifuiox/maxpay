import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/rehcarge_offer_model.dart';
import 'package:maxpay/core/domain/repository/offer_recharge_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class OfferRechargeRepoImpl implements OfferRechargeRepository {
  final ApiService apiService;

  OfferRechargeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, RechargeOffer>> offer({
    required String mobile,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.offer,
        data: {"mobile": mobile},
      );

    
    

      AppLogger.logError("=========== 👍REQUEST BODY ===========");
      AppLogger.logError({
        "mobile": mobile,
       
      });

      AppLogger.logError("=========== 👍RAW RESPONSE ===========");
      AppLogger.logError(response);
      AppLogger.logError("====================================");
      final model = RechargeOffer.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

