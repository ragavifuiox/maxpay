import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';

import 'package:maxpay/core/data/model/tab_detail.dart';
import 'package:maxpay/core/domain/repository/tab_detail_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class TabdetailRepoImpl implements TabDetailRepository {
  final ApiService apiService;
  TabdetailRepoImpl(this.apiService);
  @override
  Future<Either<Failure, TabDetail>> gettabdetail({
    required String tabid,
  }) async {
    AppLogger.debugPrint(tabid);
    try {
      final response = await apiService.get("${ApiRoutes.tabdetail}$tabid");
      final model = TabDetail.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

