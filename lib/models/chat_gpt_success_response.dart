class ChatGPTSuccessResponse {
  ChatGPTSuccessResponse({
    this.id,
    this.object,
    this.created,
    this.model,
    this.choices,
    this.usage,
    this.systemFingerprint,
  });

  ChatGPTSuccessResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    object = json["object"];
    created = json["created"];
    model = json["model"];
    if (json["choices"] != null) {
      choices = <Choices>[];
      for (final dynamic v in json["choices"] as List<dynamic>) {
        choices!.add(Choices.fromJson(v));
      }
    }
    usage = json["usage"] != null ? Usage.fromJson(json["usage"]) : null;
    systemFingerprint = json["system_fingerprint"];
  }
  String? id;
  String? object;
  int? created;
  String? model;
  List<Choices>? choices;
  Usage? usage;
  String? systemFingerprint;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["object"] = object;
    data["created"] = created;
    data["model"] = model;
    if (choices != null) {
      data["choices"] = choices!.map((Choices v) => v.toJson()).toList();
    }
    if (usage != null) {
      data["usage"] = usage!.toJson();
    }
    data["system_fingerprint"] = systemFingerprint;
    return data;
  }
}

class Choices {
  Choices({this.index, this.message, this.logprobs, this.finishReason});

  Choices.fromJson(Map<String, dynamic> json) {
    index = json["index"];
    message =
        json["message"] != null ? Message.fromJson(json["message"]) : null;
    logprobs = json["logprobs"];
    finishReason = json["finish_reason"];
  }
  int? index;
  Message? message;
  dynamic logprobs;
  String? finishReason;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["index"] = index;
    if (message != null) {
      data["message"] = message!.toJson();
    }
    data["logprobs"] = logprobs;
    data["finish_reason"] = finishReason;
    return data;
  }
}

class Message {
  Message({this.role, this.content});

  Message.fromJson(Map<String, dynamic> json) {
    role = json["role"];
    content = json["content"];
  }
  String? role;
  String? content;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["role"] = role;
    data["content"] = content;
    return data;
  }
}

class Usage {
  Usage({this.promptTokens, this.completionTokens, this.totalTokens});

  Usage.fromJson(Map<String, dynamic> json) {
    promptTokens = json["prompt_tokens"];
    completionTokens = json["completion_tokens"];
    totalTokens = json["total_tokens"];
  }
  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["prompt_tokens"] = promptTokens;
    data["completion_tokens"] = completionTokens;
    data["total_tokens"] = totalTokens;
    return data;
  }
}
