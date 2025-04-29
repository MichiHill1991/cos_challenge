import 'package:cos_challenge/model/multiple_choices.dart';
import 'package:flutter/material.dart';

class MultipleChoicesPage extends StatelessWidget {
  final List<MultipleChoices> data;

  const MultipleChoicesPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Selector")),
      body: const Placeholder(),
    );
  }
}
