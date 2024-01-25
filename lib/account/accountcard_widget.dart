import 'package:flutter/material.dart';


class ProfileCardWidget extends StatelessWidget {
  final Widget child;
  const ProfileCardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10)),
            child: child));
  }
}
