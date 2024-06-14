import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:anbar_supliar/consts/consts.dart';
import '../../views/Order_Details_Screen/order_detail.dart';
import 'model_class.dart';
import 'service_function.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Orders>>(
      future: fetchAllOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Orders order = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 219,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: blackColor.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0,
                            4),
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
                              'Order # ${order.number}',
                              style: const TextStyle(
                                color: blackColor,
                                fontSize: 14,
                                fontFamily: bold,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Get.to(() => OrderDetailScreen(orderId: order.id));
                                // Get.to(()=> const OrderDetailScreen());
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
                              order.title,
                              // snapshot.data!.title,
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
                              order.quantity.toString(),
                              // snapshot.data!.quantity.toString(),
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
                                    order.location,
                                    // snapshot.data!.location,
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
            },
          );
        } else {
          return const Center(child: Text('No orders found'));
        }
      },
    );
  }
}