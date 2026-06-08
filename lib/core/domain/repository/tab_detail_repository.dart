import 'package:dartz/dartz.dart';

import 'package:maxpay/core/data/model/tab_detail.dart';
import 'package:maxpay/core/error/failure.dart';



abstract class TabDetailRepository {
  Future<Either<Failure, TabDetail >> gettabdetail({
    required String tabid,
  });
}
