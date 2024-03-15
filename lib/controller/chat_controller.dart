import "package:chat_gpt_demo/models/chat_gpt_custom_model.dart";
import "package:chat_gpt_demo/models/chat_gpt_failure_response.dart";
import "package:chat_gpt_demo/models/chat_gpt_success_response.dart";
import "package:chat_gpt_demo/service/api_service.dart";
import "package:get/get.dart";

class ChatController extends GetxController {
  final RxList<CustomModel> chatList = <CustomModel>[].obs;

  Future<void> makAnAPICall({
    required String role,
    required String content,
    required Function(ChatGPTSuccessResponse response) successCallback,
    required Function(ChatGPTFailureResponse response) failureCallback,
  }) async {
    await APIService().funcOpenAIAPI(
      role: role,
      content: content,
      successCallback: successCallback,
      failureCallback: failureCallback,
    );
    return Future<void>.value();
  }
}
