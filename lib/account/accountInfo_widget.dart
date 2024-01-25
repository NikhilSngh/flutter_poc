import 'package:flutter/material.dart';


class Info extends StatelessWidget {
  final String label;
  final String value;
  const Info(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(children: [Text(label), const Spacer(), Text(value)]));
  }
}
