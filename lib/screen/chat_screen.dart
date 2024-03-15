import "package:chat_gpt_demo/controller/chat_controller.dart";
import "package:chat_gpt_demo/models/chat_gpt_custom_model.dart";
import "package:chat_gpt_demo/models/chat_gpt_failure_response.dart";
import "package:chat_gpt_demo/models/chat_gpt_success_response.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class ChatScreen extends GetView<ChatController> {
  ChatScreen({super.key});

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat GPT Demo")),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: Obx(listViewMainWidget)),
            textFieldWidget(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget listViewMainWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: controller.chatList.length,
        reverse: true,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (BuildContext context, int index) {
          final CustomModel data = controller.chatList.reversed.toList()[index];
          return listViewAdapterWidget(data);
        },
      ),
    );
  }

  Widget listViewAdapterWidget(CustomModel data) {
    return Align(
      alignment: decideAlign(data),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          topMostLeftOrRightWidget(data, isForLeft: true),
          topMostLeftOrRightbesideWidget(data, isForLeft: true),
          flexibleChatMessageCard(data),
          topMostLeftOrRightWidget(data, isForLeft: false),
          topMostLeftOrRightbesideWidget(data, isForLeft: false),
        ],
      ),
    );
  }

  Widget topMostLeftOrRightWidget(CustomModel data, {required bool isForLeft}) {
    return isForLeft
        ? SizedBox(width: decideAlign(data) == Alignment.centerLeft ? 0 : 32)
        : SizedBox(width: decideAlign(data) == Alignment.centerRight ? 0 : 32);
  }

  Widget topMostLeftOrRightbesideWidget(
    CustomModel data, {
    required bool isForLeft,
  }) {
    return isForLeft
        ? (decideAlign(data) == Alignment.centerLeft)
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: customCircleAvatar(Icons.blur_on),
              )
            : const SizedBox()
        : (decideAlign(data) == Alignment.centerRight)
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: customCircleAvatar(Icons.account_circle),
              )
            : const SizedBox();
  }

  Widget customCircleAvatar(IconData iconData) {
    return Card(
      elevation: 4,
      shape: const CircleBorder(),
      child: Icon(iconData),
    );
  }

  Widget flexibleChatMessageCard(CustomModel data) {
    return Flexible(
      child: Card(
        elevation: 4,
        color: Theme.of(Get.context!).colorScheme.primary,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            data.messageText,
            style: TextStyle(
              color: Theme.of(Get.context!).scaffoldBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }

  Alignment decideAlign(CustomModel data) {
    return data.messageGeneratedByAI
        ? Alignment.centerLeft
        : Alignment.centerRight;
  }

  Widget textFieldWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: "Message",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          suffixIcon: IconButton(
            onPressed: funcSend,
            icon: CircleAvatar(
              backgroundColor: Theme.of(Get.context!).colorScheme.primary,
              child: Icon(
                Icons.send,
                color: Theme.of(Get.context!).scaffoldBackgroundColor,
                size: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> funcSend() async {
    final String message = _textEditingController.value.text.trim();
    _textEditingController.clear();
    if (message.isEmpty) {
    } else {
      final CustomModel sendMessage = funcSendMessage(message);
      await controller.makAnAPICall(
        role: sendMessage.messageSenderRole,
        content: sendMessage.messageText,
        successCallback: successCallbackAction,
        failureCallback: failureCallbackAction,
      );
      _scrollController.jumpTo(_scrollController.position.minScrollExtent);
    }
    return Future<void>.value();
  }

  CustomModel funcSendMessage(String message) {
    final CustomModel data = CustomModel(
      messageId: "",
      messageSenderRole: "user",
      messageText: message,
      messageTimestamp: DateTime.now().millisecondsSinceEpoch,
      messageGeneratedByAI: false,
    );
    controller.chatList.add(data);
    return data;
  }

  CustomModel successCallbackAction(ChatGPTSuccessResponse response) {
    final CustomModel data = CustomModel(
      messageId: response.id ?? "",
      messageSenderRole: response.choices?.last.message?.role ?? "",
      messageText: response.choices?.last.message?.content ?? "",
      messageTimestamp: response.created ?? 0,
      messageGeneratedByAI: true,
    );
    controller.chatList.add(data);
    return data;
  }

  void failureCallbackAction(ChatGPTFailureResponse response) {
    final GetSnackBar snackBar = GetSnackBar(
      message: response.error?.message,
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.red,
    );
    Get.showSnackbar(snackBar);
    return;
  }
}
