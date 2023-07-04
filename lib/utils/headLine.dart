import 'package:flutter/material.dart';

import 'font_style.dart';

class HeadLineText extends StatelessWidget {
  final String heading;

   const HeadLineText({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
         CommonText(
          text: heading,
          style: FontStyles.heading4,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 6,
          width: 120,
          color: Theme.of(context).indicatorColor,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
