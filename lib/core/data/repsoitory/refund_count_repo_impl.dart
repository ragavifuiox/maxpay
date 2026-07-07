import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/refund_count_model.dart';
import 'package:maxpay/core/domain/repository/refund_count_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class RefundCountRepoImpl implements RefundCountRepository {
  final ApiService apiService;
  RefundCountRepoImpl(this.apiService);

  @override
  Future<Either<Failure, RefundCount>> refundcount() async {
    try {
      final response = await apiService.get(ApiRoutes.refundcount);
      final model = RefundCount.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
