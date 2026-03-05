// lib/models/response_data_map.dart

class ResponseDataMap {
  final bool status;
  final String? message;
  final dynamic data;

  ResponseDataMap({
    required this.status,
    this.message,
    this.data,
  });
}