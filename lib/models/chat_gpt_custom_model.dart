class CustomModel {
  CustomModel({
    required this.messageId,
    required this.messageSenderRole,
    required this.messageText,
    required this.messageTimestamp,
    required this.messageGeneratedByAI,
  });
  final String messageId;
  final String messageSenderRole;
  final String messageText;
  final int messageTimestamp;
  final bool messageGeneratedByAI;
}

CustomModel emptyModel() {
  return CustomModel(
    messageId: "",
    messageSenderRole: "",
    messageText: "",
    messageTimestamp: 0,
    messageGeneratedByAI: false,
  );
}
