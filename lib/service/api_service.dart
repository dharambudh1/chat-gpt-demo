import "dart:io";

import "package:chat_gpt_demo/models/chat_gpt_failure_response.dart";
import "package:chat_gpt_demo/models/chat_gpt_success_response.dart";
import "package:get/get.dart";

class APIService extends GetConnect {
  factory APIService() {
    return _singleton;
  }

  APIService._internal();

  static final APIService _singleton = APIService._internal();

  static String baseURL = "https://api.openai.com";
  static String baseURLVer = "/v1";
  static String baseURLEndPoint = "/chat/completions";
  static String token = "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";
  static String url = "$baseURL$baseURLVer$baseURLEndPoint";

  Future<void> funcOpenAIAPI({
    required String role,
    required String content,
    required Function(ChatGPTSuccessResponse response) successCallback,
    required Function(ChatGPTFailureResponse response) failureCallback,
  }) async {
    final Map<String, String> requestheaders = <String, String>{
      "Authorization": "Bearer $token",
    };
    final Map<String, dynamic> requestBody = <String, Object>{
      "model": "gpt-3.5-turbo",
      "messages": <Map<String, dynamic>>[
        <String, dynamic>{"role": role, "content": content},
      ],
    };

    final Response<dynamic> response = await post(
      url,
      requestBody,
      headers: requestheaders,
    );

    response.statusCode == HttpStatus.ok
        ? successCallback(ChatGPTSuccessResponse.fromJson(response.body))
        : failureCallback(ChatGPTFailureResponse.fromJson(response.body));
    return Future<void>.value();
  }
}
