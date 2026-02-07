import 'api_error.dart';
import 'api_status.dart';

class ApiResponse<T> {
  ApiStatus status;
  ApiError? error;
  T? data;
  String? errorMsg;
  int? statusCodeServer;

  ApiResponse.success(
      {this.status = ApiStatus.success, this.data, this.statusCodeServer});

  ApiResponse.error(
      {this.status = ApiStatus.error,
      this.error,
      this.errorMsg,
      this.statusCodeServer});
}
