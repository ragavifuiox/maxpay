import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/payment_product_model.dart';
import 'package:maxpay/core/domain/repository/payment_status_type_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class CashbackTypeUsecase {
  final CashbackTypeRepository repository;
  CashbackTypeUsecase(this.repository);
  Future<Either<Failure, CashbackProductType>> call() {
    return repository.getpaymentproducttype();
  }
}
