import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:http_parser/http_parser.dart';
import 'package:tasky_app/features/create_task/model/create_task_request.dart';
import 'package:tasky_app/features/create_task/model/task_model.dart';
import 'package:tasky_app/shared/error/failures.dart';
import 'package:tasky_app/shared/utils/local_storage/shared_pref_service.dart';

import '../../../shared/error/custom_error_handler.dart';
import '../../../shared/networking/api_constants.dart';

class CreateTaskRepository {
  CreateTaskRepository({
    required Dio dio,
  }) : _dio = dio;
  final Dio _dio;

  Future<Either<Failure, String>> uploadImage({
    required String imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imagePath,
          contentType: MediaType('image', 'jpg'),
        ),
      });

      final response = await _dio.post(
        '${ApiConstants.baseUrl}/upload/image',
        data: formData,
      );

      return Right('${ApiConstants.baseUrl}/images/${response.data['image']}');
    } on DioException catch (dioError) {
      final errorMessage = CustomErrorHandler.handleDioError(dioError);
      return Left(Failure(message: errorMessage));
    } catch (error) {
      final errorMessage = CustomErrorHandler.handleError(error);
      return Left(Failure(message: errorMessage));
    }
  }

  Future<Either<Failure, TaskModel>> createTask({
    required CreateTaskRequest data,
  }) async {
    try {
      print(SharedPrefHelper.instance.getString('access_token'));
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/todos',
        data: data.toJson(),
      );
      if (response.statusCode != 201) {
        return Left(Failure(message: 'Something went wrong.'));
      }
      return Right(TaskModel.fromJson(response.data));
    } on DioException catch (dioError) {
      final errorMessage = CustomErrorHandler.handleDioError(dioError);
      return Left(Failure(message: errorMessage));
    } catch (error) {
      final errorMessage = CustomErrorHandler.handleError(error);
      return Left(Failure(message: errorMessage));
    }
  }
}
