import 'package:anbar_supliar/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/our_button.dart';
import '../Home_screen/home_screen.dart';
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

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      Get.to(const HomeScreen());
    }).onError((error, stackTrace) {
      Get.snackbar(
        error.toString(),
        stackTrace.toString(),
        backgroundColor: primaryColor,
        colorText: whiteColor,
      );
    });
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
                    PasswordField(),
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
                      // Get.to(()=> const LoginScreen());
                      login();
                    }
                  },
                  color: primaryColor,
                  textColor: whiteColor,
                  title: Login,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
