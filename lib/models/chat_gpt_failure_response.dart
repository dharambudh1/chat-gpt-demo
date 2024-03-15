class ChatGPTFailureResponse {
  ChatGPTFailureResponse({this.error});

  ChatGPTFailureResponse.fromJson(Map<String, dynamic> json) {
    error = json["error"] != null ? Error.fromJson(json["error"]) : null;
  }
  Error? error;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (error != null) {
      data["error"] = error!.toJson();
    }
    return data;
  }
}

class Error {
  Error({this.message, this.type, this.param, this.code});
  Error.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    type = json["type"];
    param = json["param"];
    code = json["code"];
  }
  String? message;
  String? type;
  dynamic param;
  String? code;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message"] = message;
    data["type"] = type;
    data["param"] = param;
    data["code"] = code;
    return data;
  }
}
