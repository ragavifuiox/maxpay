import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';

import 'package:maxpay/core/data/model/tab_detail.dart';
import 'package:maxpay/core/domain/repository/tab_detail_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class TabdetailRepoImpl implements TabDetailRepository {
  final ApiService apiService;
  TabdetailRepoImpl(this.apiService);
  @override
  Future<Either<Failure, TabDetail>> gettabdetail({
    required String tabid,

  }) async {
    print(tabid);
    try {
      final response = await apiService.get(
       "${ApiRoutes.tabdetail}$tabid"
      );
      final model = TabDetail.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}