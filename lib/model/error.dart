class ErrorMessage {
  String msgKey;
  Params params;
  String message;

  ErrorMessage({
    required this.msgKey,
    required this.params,
    required this.message,
  });

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(
      msgKey: json["msgKey"],
      params: Params.fromJson(json["params"]),
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"msgKey": msgKey, "params": params.toJson(), "message": message};
  }
}

class Params {
  String delaySeconds;

  Params({required this.delaySeconds});

  factory Params.fromJson(Map<String, dynamic> json) {
    return Params(delaySeconds: json["delaySeconds"]);
  }

  Map<String, dynamic> toJson() {
    return {"delaySeconds": delaySeconds};
  }
}
