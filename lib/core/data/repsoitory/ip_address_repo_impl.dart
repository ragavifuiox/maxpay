

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/id_address_model.dart';
import 'package:maxpay/core/domain/repository/ip_address_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class IpAddressRepoImpl implements IpAddressRepository {
  final ApiService apiService;

  IpAddressRepoImpl(this.apiService);

  @override
  Future<Either<Failure, IpAddress>> ipaddress({
    required String ipaddress,
    required String city,
    required String network,
    required String state,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.getip,
  data: {
    "ip_address": ipaddress,
    "city": city,
    "network": network,
    "state": state,
  },
);

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
 "ip_address": ipaddress,
    "city": city,
    "network": network,
    "state": state,
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = IpAddress.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    
