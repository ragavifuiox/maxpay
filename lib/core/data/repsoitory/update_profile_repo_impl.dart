import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dartz/dartz.dart';

import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/profile_update_model.dart';
import 'package:maxpay/core/domain/repository/profile_update_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class UpdateProfileRepoImpl implements ProfileUpdateRepository {
  final ApiService apiService;

  UpdateProfileRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ProfileUpdate>> updateprofile({
    required String pincode,
    required String email,
    required String mobilenumber,
    File? profileimage,
    required String name,
    required String whatsappnumber,
    required String address,
  }) async {
    try {
      final formData = FormData.fromMap({
        "pincode": pincode,
        "email": email,
        "reg_mobile_number": mobilenumber,
        "retailer_name": name,
        "whatsapp_number": whatsappnumber,
        "billing_address": address,
        if (profileimage != null)
          "profile_img": await MultipartFile.fromFile(
            profileimage.path,
            filename: profileimage.path.split('/').last,
            contentType: MediaType('image', 'jpeg'),
          ),
      });


      final response = await apiService.post(

        ApiRoutes.updateprofile,
        data: formData,
      );

      final model = ProfileUpdate.fromJson(response);
      return Right(model);
    } catch (e) {
      
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
