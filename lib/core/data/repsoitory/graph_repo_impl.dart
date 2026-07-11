import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/graph_model.dart';
import 'package:maxpay/core/domain/repository/graph_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class GraphRepoImpl implements GraphRepository {
  final ApiService apiService;
  GraphRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Graph>> graph() async {
    try {
      final response = await apiService.get(ApiRoutes.graph);
      final model = Graph.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
