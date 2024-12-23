import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:tasky_app/features/auth/signup/model/signup_response_model.dart';
import 'package:tasky_app/shared/error/failures.dart';
import 'package:tasky_app/shared/networking/api_constants.dart';
import 'package:tasky_app/shared/error/custom_error_handler.dart'; // Import the handler

import '../model/signup_model.dart';

class SignupRemoteRepository {
  SignupRemoteRepository({
    required Dio dio,
  }) : _dio = dio;
  final Dio _dio;

  Future<Either<Failure, SignupResponseModel>> signup({
    required SignupModel data,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/auth/register',
        data: data.toMap(),
      );
      if (response.statusCode != 201) {
        return Left(Failure(message: 'Something went wrong.'));
      }
      return Right(SignupResponseModel.fromMap(response.data));
    } on DioException catch (dioError) {
      final errorMessage = CustomErrorHandler.handleDioError(dioError);
      return Left(Failure(message: errorMessage));
    } catch (error) {
      final errorMessage = CustomErrorHandler.handleError(error);
      return Left(Failure(message: errorMessage));
    }
  }
}
