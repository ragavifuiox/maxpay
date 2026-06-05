import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/add_staff_model.dart';
import 'package:maxpay/core/data/model/create_pin_model.dart';

import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/data/model/otp_response_model.dart';
import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/data/model/search_staff_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class SearchStaffRepository {
  Future<Either<Failure, SearchStaff>> searchStaff({
    required String mobile,
  });
}
  
