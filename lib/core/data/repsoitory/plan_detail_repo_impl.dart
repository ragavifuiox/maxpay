import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/plan_detail_model.dart';

import 'package:maxpay/core/data/model/plan_model.dart';
import 'package:maxpay/core/domain/repository/plan_detail_repository.dart';
import 'package:maxpay/core/domain/repository/plan_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class PlanDetailRepoImpl implements PlanDetailRepository {
  final ApiService apiService;
  PlanDetailRepoImpl(this.apiService);
  @override
  Future<Either<Failure, PlanDetail>> getplandetail({
    required String Planid,

  }) async {
    print(Planid);
    try {
      final response = await apiService.get(
       "${ApiRoutes.getplandetail}$Planid"
      );
      final model = PlanDetail.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}