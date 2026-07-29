

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/update_payment_status.dart';
import 'package:maxpay/core/domain/repository/update_payment_status_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class UpdatePaymentStatusUsecase {
  final UpdatePaymentStatusRepository repository;

  UpdatePaymentStatusUsecase(this.repository);

  Future<Either<Failure, UpdatePaymentStatus>> call({
    required String rechargeId,
    required String status,
  }) {
    return repository.udpatestatus(
      rechargeid: rechargeId,
      status: status,
    );
  }
}
