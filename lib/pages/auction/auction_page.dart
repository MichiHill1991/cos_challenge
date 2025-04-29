import 'package:cos_challenge/model/success.dart';
import 'package:flutter/material.dart';

class AuctionPage extends StatelessWidget {
  final Success data;

  const AuctionPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Action Page")),
      body: const Placeholder(),
    );
  }
}
