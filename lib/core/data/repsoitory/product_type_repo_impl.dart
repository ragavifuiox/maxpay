import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/product_type.dart';
import 'package:maxpay/core/domain/repository/product_type_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class ProductTypeRepoImpl implements ProductTypeRepository {
  final ApiService apiService;
  ProductTypeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ProductType>> getProductTypes() async {
    try {
      final response = await apiService.get(ApiRoutes.productype);
      final model = ProductType.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
