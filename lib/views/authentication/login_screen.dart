import 'package:anbar_supliar/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/navigation_menue.dart';
import '../../common_widgets/our_button.dart';
import 'components/email_field/email_field.dart';
import 'components/Password_field/password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.to(const NavigationMenu());
    } on FirebaseAuthException catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        e.message ?? 'An unknown error occurred',
        backgroundColor: primaryColor,
        colorText: whiteColor,
      );
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'An unknown error occurred',
        backgroundColor: primaryColor,
        colorText: whiteColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Image.asset(
                  imgAnbarTitleCl,
                ),
              ),
              const SizedBox(height: 80),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    EmailField(emailController: emailController),
                    const SizedBox(height: 20),
                    PasswordField(passwordController: passwordController),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 40,
                width: 298,
                child: ourButton(
                  onPress: () {
                    if (_formkey.currentState!.validate()) {
                      login();
                    }
                  },
                  color: primaryColor,
                  textColor: whiteColor,
                  title: 'Login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
