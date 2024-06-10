import 'package:anbar_supliar/consts/consts.dart';
import 'package:anbar_supliar/views/Home_screen/Components/new_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

import '../../Models/ui_card.dart';
import '../Order_Details_Screen/order_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                color: primaryColor,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, left: 8.0),
                          child: Center(
                            child: Image.asset(
                              imgLogo2,
                              height: 45,
                              width: 165,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Card(
                        elevation: 5,
                        child: Container(
                          height: 85,
                          width: 144,
                          color: lowGreenColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 19.0, left: 19),
                                child: Text(
                                  myStatus,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: semibold),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    actlight,
                                    height: 23,
                                    width: 23,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    active,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: semibold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: Container(
                        height: 85,
                        width: 144,
                        color: purpalColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 19.0, left: 19),
                              child: Text(
                                completedOrder,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: semibold),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  tick,
                                  height: 23,
                                  width: 23,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  '102',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: semibold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get.to(()=> const MyInventory());
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          height: 85,
                          width: 144,
                          color: lightBlueColor,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                myInventory,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: semibold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              new_Orders(),
              const SizedBox(height: 10),
              Padding(
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
                            const Text(
                              ordernumber,
                              style: TextStyle(
                                color: blackColor,
                                fontSize: 14,
                                fontFamily: bold,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
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
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              ACinstalling,
                              style: TextStyle(
                                color: blackColor,
                                fontFamily: bold,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              quantity,
                              style: TextStyle(
                                fontFamily: bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              '2',
                              style: TextStyle(
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
                            const SizedBox(width: 2),
                            const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    locationName,
                                    style: TextStyle(
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
              ),
              const SizedBox(height: 10),
              const OrderDetailWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

