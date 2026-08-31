import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/delete_staff_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class DeleteStaffRepository {
  Future<Either<Failure, DeleteStaffModel>> deleteStaff({
    required String staffId,
  });
}
