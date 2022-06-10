import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('About'),
          centerTitle: true,
          backgroundColor: Color(0xFF005b71),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(children: [
                SizedBox(height: 50),
                Text("Version : ",
                    style: TextStyle(color: Color(0xFF005b71), fontSize: 20)),
                Text("1.0.0  ", style: TextStyle(fontSize: 20))
              ]),
            ],
          ),
        ));
  }
}
