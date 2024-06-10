import 'package:flutter/material.dart';

import '../consts/styles.dart';

Widget ourButton({Function()? onPress, Color? color, Color? textColor, String? title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPress,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title ?? '',
          style: TextStyle(color: textColor, fontFamily: semibold, fontSize: 14),
        ),
      ],
    ),
  );
}