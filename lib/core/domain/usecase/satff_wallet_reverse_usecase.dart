import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/staff_wallet_reverse_model.dart';
import 'package:maxpay/core/domain/repository/staff_wallet_reverse_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class SatffWalletReverseUsecase {
  final StaffWalletReverseRepository repository;
  SatffWalletReverseUsecase(this.repository);
  Future<Either<Failure, StaffReverse>> call({
    required String id,

  }) {
    return repository.staffreverse(
id: id,
   
    );
  }
}
