import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../common_widgets/navigation_menue.dart';
import '../../Landing_Screen/Landing_Screen.dart';

class SplashServices {
  void changeScreen() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.to(() => const NavigationMenu());
        // Get.off(const HomeScreen());
      });
    } else {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          Get.to(() => const LandingScreen());
        },
      );
    }
  }
}
