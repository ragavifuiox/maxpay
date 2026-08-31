import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/delete_staff_model.dart';
import 'package:maxpay/core/domain/repository/delete_staff_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class DeleteStaffUsecase {
  final DeleteStaffRepository repository;

  DeleteStaffUsecase(this.repository);

  Future<Either<Failure, DeleteStaffModel>> call(String staffId) {
    return repository.deleteStaff(staffId: staffId);
  }
}
