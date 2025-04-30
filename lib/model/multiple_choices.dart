import 'dart:convert';

import 'package:cos_challenge/utils/color.dart';
import 'package:flutter/material.dart';

List<MultipleChoices> listFromJson(String str) {
  final list = List<MultipleChoices>.from(
    jsonDecode(str).map((x) => MultipleChoices.fromJson(x)),
  );
  list.sort((a, b) => b.similarity.compareTo(a.similarity));
  return list;
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

  IconData getIcon() {
    if (similarity > 75) return Icons.thumb_up;
    if (similarity >= 50) return Icons.thumbs_up_down;
    return Icons.thumb_down;
  }

  Color getColor() {
    if (similarity > 75) return BrandColors.limeGreen;
    if (similarity >= 50) return BrandColors.neutral200;
    return BrandColors.tomato;
  }
}
