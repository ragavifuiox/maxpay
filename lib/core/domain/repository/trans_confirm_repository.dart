import 'package:dartz/dartz.dart';

import 'package:maxpay/core/data/model/trans_confirm_model.dart';
import 'package:maxpay/core/error/failure.dart';



abstract class TransConfirmRepository {
  Future<Either<Failure, TransConfirm >> getTransactionConfirm({
    required String prodcutdetid,
  });
}
