import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/add_staff_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class AddStaffRepository {
  Future<Either<Failure, AddStaff>> addStaff({
    required String name,
   
    required String phone,
    required String package
   
  });

  }
