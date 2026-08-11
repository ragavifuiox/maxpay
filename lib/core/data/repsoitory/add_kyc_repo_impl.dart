import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/kyc_add_response.dart';
import 'package:maxpay/core/domain/repository/kyc_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class AddKycRepoImpl implements KycRepository {
  final ApiService apiService;

  AddKycRepoImpl(this.apiService);

  @override
  Future<Either<Failure, KycAddResponse>> addKyc(
    String email,
    File idProof,
    File gstNo,
    File pan,
  ) async {
    try {
      final formData = FormData.fromMap({
        "email": email,
        "address": await MultipartFile.fromFile(
          idProof.path,
          filename: idProof.path.split('/').last,
        ),
        "gst_no": await MultipartFile.fromFile(
          gstNo.path,
          filename: gstNo.path.split('/').last,
        ),
        "pan": await MultipartFile.fromFile(
          pan.path,
          filename: pan.path.split('/').last,
        ),
      });

      final response = await apiService.post(ApiRoutes.addKyc, data: formData);

      AppLogger.logError("=========== 👍RAW RESPONSE ===========");
      AppLogger.logError(response);
      AppLogger.logError("====================================");

      final model = KycAddResponse.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

