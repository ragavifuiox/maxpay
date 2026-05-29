import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/staff_lsit_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class StaffListRepository {
  Future<Either<Failure, StaffList>> getStaffList();
}
