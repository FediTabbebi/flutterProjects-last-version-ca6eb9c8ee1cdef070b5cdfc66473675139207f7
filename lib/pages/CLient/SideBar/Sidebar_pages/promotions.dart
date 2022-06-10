import 'package:flutter/material.dart';

class Promotion extends StatelessWidget {
  const Promotion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promotion'),
        centerTitle: true,
        backgroundColor: Color(0xFF005b71),
      ),
    );
  }
}
