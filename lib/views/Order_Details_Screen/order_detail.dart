import 'package:anbar_supliar/consts/consts.dart';
import 'package:flutter/material.dart';
import '../../Models/model_class.dart';
import '../../Models/service_function.dart';
import '../../common_widgets/our_button.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Orders?>(
      future: fetchOrderDetails('MnD8li8kycOo7TtFbDUO'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            strokeAlign: double.infinity,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: primaryColor,
              title: const Text(
                orderDetails,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: bold,
                  fontSize: 22,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    color: whiteColor,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: semibold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Lorem ipsum dolor sit amet consectetur. Dui dignissim massa magna urna augue cursus tempor vitae. Nulla mus urna.......',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                numberOfUnits,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                snapshot.data!.quantity.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            clientInformation,
                            style:
                                TextStyle(fontSize: 18, fontFamily: semibold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                name,
                                style: TextStyle(
                                    fontSize: 14, fontFamily: semibold),
                              ),
                              Text(
                                snapshot.data!.clientName.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                contactNumber,
                                style: TextStyle(
                                    fontSize: 14, fontFamily: semibold),
                              ),
                              Text(
                                snapshot.data!.contactNumber.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                date,
                                style: TextStyle(
                                    fontSize: 14, fontFamily: semibold),
                              ),
                              Text(
                                snapshot.data!.date.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                price,
                                style: TextStyle(
                                    fontSize: 14, fontFamily: semibold),
                              ),
                              Text(
                                'SAR ${snapshot.data!.price.toString()}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Image.asset('assets/images/map_placeholder.png'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            clientNotes,
                            style:
                                TextStyle(fontSize: 18, fontFamily: semibold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            snapshot.data!.notes,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: 280,
                    height: 40,
                    child: ourButton(
                        onPress: () {},
                        color: primaryColor,
                        textColor: whiteColor,
                        title: acceptOrder),
                  ),
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