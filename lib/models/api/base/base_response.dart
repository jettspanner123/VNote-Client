class BaseResponse {
  final bool success;
  final String message;

  const BaseResponse({required this.message, required this.success});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(message: json['message'], success: json['success']);
  }
}
