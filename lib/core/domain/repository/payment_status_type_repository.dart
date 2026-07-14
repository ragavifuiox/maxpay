import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/payment_product_model.dart';
import 'package:maxpay/core/data/model/wallet_balance.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class CashbackTypeRepository {
  Future<Either<Failure, CashbackProductType>> getpaymentproducttype();
}
