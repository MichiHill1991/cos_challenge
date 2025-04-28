import 'dart:convert';

List<MultipleChoices> errorFromJson(String str) {
  return List<MultipleChoices>.from(
    jsonDecode(str).map((x) => MultipleChoices.fromJson(x)),
  );
}

class MultipleChoices {
  String make;
  String model;
  String containerName;
  int similarity;
  String externalId;

  MultipleChoices({
    required this.make,
    required this.model,
    required this.containerName,
    required this.similarity,
    required this.externalId,
  });

  factory MultipleChoices.fromJson(Map<String, dynamic> json) {
    return MultipleChoices(
      make: json["make"],
      model: json["model"],
      containerName: json["containerName"],
      similarity: json["similarity"],
      externalId: json["externalId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "make": make,
      "model": model,
      "containerName": containerName,
      "similarity": similarity,
      "externalId": externalId,
    };
  }
}
