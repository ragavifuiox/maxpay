



import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/refund_count_model.dart';
import 'package:maxpay/core/domain/repository/refund_count_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class RefundCountUsecase {
  final RefundCountRepository repository;
  RefundCountUsecase(this.repository);
  Future<Either<Failure, RefundCount>> call() {
    return repository.refundcount();
  }
}
