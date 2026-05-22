import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/data/model/product_type.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/domain/repository/product_type_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class ProductTypeUseCase {
  final ProductTypeRepository repository;
  ProductTypeUseCase(this.repository);
  Future<Either<Failure, ProductType>> call() {
    return repository.getProductTypes();
  }
}
