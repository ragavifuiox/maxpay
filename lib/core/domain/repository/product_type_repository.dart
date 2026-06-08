import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/product_type.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class ProductTypeRepository {
  Future<Either<Failure, ProductType>> getProductTypes();
}
