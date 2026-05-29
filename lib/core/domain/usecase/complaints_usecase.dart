



import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/compalints_model.dart';
import 'package:maxpay/core/domain/repository/compalints_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class ComplaintsUseCase {
  final ComplaintsRepository repository;
  ComplaintsUseCase(this.repository);
  Future<Either<Failure, Complaints>> call() {
    return repository.complaints();
  }
}
