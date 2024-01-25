import 'package:flutter/material.dart';
import 'package:flutter_poc/constant/padding_constants.dart';


class Info extends StatelessWidget {
  final String label;
  final String value;
  const Info(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppPaddings.small),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(label,style:  Theme
                .of(context)
                .textTheme
                .titleSmall,),
          Text(value,style:  Theme
              .of(context)
              .textTheme
              .titleSmall)]));
  }
}
