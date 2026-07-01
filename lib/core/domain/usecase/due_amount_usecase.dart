



import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/compalints_model.dart';
import 'package:maxpay/core/data/model/due_amount_model.dart';
import 'package:maxpay/core/domain/repository/compalints_repository.dart';
import 'package:maxpay/core/domain/repository/due_amount_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class DueAmountUsecase {
  final DueAmountRepository repository;
  DueAmountUsecase(this.repository);
  Future<Either<Failure, DueAmount>> call() {
    return repository.Dueamount();
  }
}
