// lib/models/response_data_list.dart

class ResponseDataList<T> {
  final bool status;
  final String? message;
  final List<T> data;

  ResponseDataList({
    required this.status,
    this.message,
    required this.data,
  });

  // Factory method (opsional, kalau dibutuhkan)
  factory ResponseDataList.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    List<T> items = [];
    if (json['data'] != null && json['data'] is List) {
      items = List<T>.from(
        (json['data'] as List).map(
          (item) => fromJson(item as Map<String, dynamic>),
        ),
      );
    }

    return ResponseDataList<T>(
      status: json['status'] ?? false,
      message: json['message'],
      data: items,
    );
  }
}