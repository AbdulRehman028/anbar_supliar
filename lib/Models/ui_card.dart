import 'package:anbar_supliar/Models/service_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import '../consts/colors.dart';
import '../consts/images.dart';
import '../consts/strings.dart';
import '../consts/styles.dart';
import '../views/Order_Details_Screen/order_detail.dart';
import 'model_class.dart';

class OrderDetailWidget extends StatelessWidget {
  const OrderDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Orders?>(
      future: fetchOrderDetails('MnD8li8kycOo7TtFbDUO'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 219,
              width: double.infinity,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: blackColor.withOpacity(0.3),
                    // Shadow color with some transparency
                    spreadRadius: 0,
                    // Extent of the shadow spread; can be set to 0
                    blurRadius: 5,
                    // Blur radius; adjust for more or less blur effect
                    offset: const Offset(0,
                        4), // Position of shadow; adjust x,y to change the shadow direction
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                         Text(
                    'Order # ${snapshot.data!.number}',
                    style: const TextStyle(
                            color: blackColor,
                            fontSize: 14,
                            fontFamily: bold,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Get.to(()=> const OrderDetailScreen());
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: lightBlueColor,
                          ),
                          child: const Text(
                            viewDetails,
                            style: TextStyle(
                              color: lightBlueColor,
                              fontSize: 12,
                              fontFamily: semibold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: RDottedLineBorder.all(
                        color: darkGreyColor,
                        width: 0,
                        dottedLength: 3,
                      ),
                    ),
                  ),
                   Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data!.title,
                          style: const TextStyle(
                            color: blackColor,
                            fontFamily: bold,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          quantity,
                          style: TextStyle(
                            fontFamily: bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          snapshot.data!.quantity.toString(),
                          style: const TextStyle(
                            color: blackColor,
                            fontFamily: bold,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image.asset(imglocation),
                        const SizedBox(width: 4),
                         Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.location,
                                style: const TextStyle(
                                  color: blackColor,
                                  fontFamily: mediam,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const Text('No data found');
        }
      },
    );
  }
}


