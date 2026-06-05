

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/add_staff_model.dart';
import 'package:maxpay/core/domain/repository/add_staff_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class AddStaffUsecase {
  final AddStaffRepository repository;
  AddStaffUsecase(this.repository);
  Future<Either<Failure, AddStaff>> call(
    String name,
    String phone,
    String package
  ) {
    return repository.addStaff(
      name: name,
      phone: phone,
      package: package

    );
  }
}
