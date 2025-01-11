import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:tasky_app/features/create_task/model/task_model.dart';
import 'package:tasky_app/shared/error/failures.dart';

import '../../../shared/error/custom_error_handler.dart';
import '../../../shared/networking/api_constants.dart';

class DeleteTaskRemoteRepository {
  const DeleteTaskRemoteRepository({
    required Dio dio,
  }) : _dio = dio;
  final Dio _dio;

  Future<Either<Failure, TaskModel>> deleteTask({
    required String taskId,
  }) async {
    try {
      final response = await _dio.delete(
        '${ApiConstants.baseUrl}/todos/$taskId',
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
