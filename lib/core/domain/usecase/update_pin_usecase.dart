

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/update_pin_model.dart';
import 'package:maxpay/core/domain/repository/update_pin_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class UpdatePinUsecase {
  final UpdatePinRepository repository;
  UpdatePinUsecase(this.repository);
  Future<Either<Failure, UpdatePin>> call(
    String newpin ,
    String confirmpin
  ) {
    return repository.updatepin(
     newpin: newpin,
     confirmpin: confirmpin
    );
  }
}
