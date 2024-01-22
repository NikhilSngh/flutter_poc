import 'package:flutter/material.dart';
import 'package:flutter_poc/theme/sizes.dart';

class DetailTextIconWidget extends StatelessWidget {
  final IconData iconData;
  final String text;

  const DetailTextIconWidget(
      {super.key, required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Colors.black,
        ),
        Container(
          margin: const EdgeInsets.only(left: Sizes.size5),
          child: Center(
            child: Text(text,
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: Sizes.size15,
                    fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }
}
