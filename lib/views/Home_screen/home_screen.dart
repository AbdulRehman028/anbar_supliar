import 'package:anbar_supliar/consts/consts.dart';
import 'package:anbar_supliar/views/Home_screen/Components/new_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Models/Order_Model/ui_card.dart';
import '../Inventory_screen/inventory_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                      Get.to(()=>  InventoryScreen());
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
            const SizedBox(height: 10),
            // const OrderDetailWidget(),
            const Expanded(child: OrdersList()),
          ],
        ),
      ),
    );
  }
}

