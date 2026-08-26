

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/wallet_trnasfer_detail.dart';
import 'package:maxpay/core/data/model/water_bill_page.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class WaterBillRepository {
  Future<Either<Failure, WaterBill>> waterbill({
    required String productId,
    required String customerId,
  });

  }
