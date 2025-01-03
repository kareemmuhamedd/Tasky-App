import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:tasky_app/features/update_task/models/update_task_request.dart';

import '../../../shared/error/custom_error_handler.dart';
import '../../../shared/error/failures.dart';
import '../../../shared/networking/api_constants.dart';
import '../../create_task/model/task_model.dart';

class UpdateTaskRemoteRepository {
  const UpdateTaskRemoteRepository({
    required Dio dio,
  }) : _dio = dio;
  final Dio _dio;

  Future<Either<Failure, TaskModel>> updateTask({
    required UpdateTaskRequest data,
    required String taskId,
  }) async {
    try {
      final response = await _dio.put(
        '${ApiConstants.baseUrl}/todos/$taskId',
        data: data.toJson(),
      );
      if (response.statusCode != 200) {
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
