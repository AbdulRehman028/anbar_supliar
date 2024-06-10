import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/our_button.dart';
import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../../consts/strings.dart';
import '../../consts/styles.dart';
import '../authentication/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               const Center(
                 child: Padding(
                   padding: EdgeInsets.only(top: 57),
                   child: Text(
                    bestHelpingLb,
                    style: TextStyle(fontSize: 32, fontFamily: bold,),
                   ),
                 ),
               ),
              // const Spacer(),
              const SizedBox(height: 95),
              Center(child: Image.asset(imgtechnician, width: 375, height: 326,)),
              const SizedBox(height: 68),
              SizedBox(
                width: 300,
                height: 52,
                child: ourButton(
                    onPress: () {
                      Get.to(()=> const LoginScreen());
                    },
                    color: primaryColor,
                    textColor: whiteColor,
                    title: getStartedLb),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
