class ErrorModel {
  bool? status;
  int? code;
  dynamic data;
  Error? error;

  ErrorModel({this.status, this.code, this.data, this.error});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'];
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['code'] = code;
    data['data'] = data;
    if (error != null) {
      data['error'] = error!.toJson();
    }
    return data;
  }
}

class Error {
  String? errorMessage;

  Error({this.errorMessage});

  Error.fromJson(Map<String, dynamic> json) {
    errorMessage = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['error_message'] = errorMessage;
    return data;
  }
}
