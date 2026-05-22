

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/create_pin_model.dart';
import 'package:maxpay/core/domain/repository/create_pin_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class CreatePinUsecase {
  final CreatePinRepository repository;
  CreatePinUsecase(this.repository);
  Future<Either<Failure, CreatePin>> call(
    String pin ,
  
  
    ) {
    return repository.createPin(
      pin: pin,
    );
  }
}
