import 'package:anbar_supliar/views/Splash_Screen/splash_services/splash_services.dart';
import 'package:flutter/material.dart';
import '../../consts/colors.dart';
import '../../consts/images.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.changeScreen();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imaganbarlogo, width: 150, height: 130, fit: BoxFit.cover,),
            const SizedBox(height: 10,),
            Image.asset(imgLogo2)
          ],
        ),
      ),
    );
  }
}
