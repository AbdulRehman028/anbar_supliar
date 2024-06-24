import 'package:anbar_supliar/consts/consts.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;

  const PasswordField({super.key, required this.passwordController});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true; // Tracks the visibility of the password

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: widget.passwordController,
        obscureText: _isObscured, // Controls visibility of the password
        style: const TextStyle(color: primaryColor), // Text color
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          labelText: 'Password',
          labelStyle: const TextStyle(color: primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
            const BorderSide(color: primaryColor),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscured ? Icons.visibility_off : Icons.visibility,
              // Toggles the icon
              color: primaryColor, // Icon color
            ),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured; // Toggle the state of the obscureText
              });
            },
          ),
        ),
        cursorColor: blackColor,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      ),
    );
  }
}
