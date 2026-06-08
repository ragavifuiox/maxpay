import 'package:dartz/dartz.dart';

import 'package:maxpay/core/data/model/search_staff_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class SearchStaffRepository {
  Future<Either<Failure, SearchStaff>> searchStaff({
    required String mobile,
  });
}
  
