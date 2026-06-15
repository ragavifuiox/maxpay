import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/dth_tab_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class DthTabRepository {
  Future<Either<Failure, DthTab>> getdthplan();
}
