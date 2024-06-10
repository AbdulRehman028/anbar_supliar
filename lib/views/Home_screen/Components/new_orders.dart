import 'package:flutter/material.dart';
import '../../../consts/colors.dart';
import '../../../consts/strings.dart';
import '../../../consts/styles.dart';

Padding new_Orders() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Container(
          height: 20,
          width: 4,
          decoration: BoxDecoration(
            color: lightPurpalColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          newOrders,
          style: TextStyle(
            color: blackColor,
            fontSize: 20,
            fontFamily: bold,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {

          },
          style: TextButton.styleFrom(
            foregroundColor: greyColor,
            textStyle: const TextStyle(fontSize: 12, fontFamily: semibold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              // Rounded corners, adjust radius as needed
              side: const BorderSide(color: lightGrey), // Light grey outline
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            // Ensures the Row takes only as much space as needed
            children: [
              Text(
                seeall,
                style: TextStyle(
                    fontSize: 12,
                    color: lightgrey,
                    fontFamily:
                        semibold // semibold is usually equivalent to w600
                    ),
              ),
              Icon(Icons.arrow_forward_ios, size: 12, color: lightgrey),
              // Small forward arrow icon
            ],
          ),
        ),
      ],
    ),
  );
}
