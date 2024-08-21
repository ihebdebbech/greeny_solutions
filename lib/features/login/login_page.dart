// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny_solution/features/login/login_controler.dart';
import 'package:shared/shared.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      resizeToAvoidBottomInset:
          true, // Ensure the layout adjusts when the keyboard appears
      body: Stack(
        children: [
          Positioned(
            top: 70,
            left: MediaQuery.of(context).size.width / 2 - 80,
            child: Image.asset(
              'assets/Images/greenywhite.png',
              width: 150,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 20),
                      LoginForm(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  LoginController loginControllerC = new LoginController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            filled: false,
            fillColor: AppColors.secondary,
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 91, 235, 175),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: AppColors.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: AppColors.primary,
              ),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 20),
        Text(
          'Password',
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            filled: false,
            fillColor: AppColors.secondary,
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 91, 235, 175),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: AppColors.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: AppColors.primary,
              ),
            ),
          ),
          obscureText: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password ?',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Obx(
          () => ElevatedButton(
            onPressed: () {
              loginControllerC.isLoading.value
                  ? null
                  : loginControllerC.login(
                      _emailController.value.text.toString(),
                      _passwordController.value.text.toString());
            },
            child: loginControllerC.isLoading.value
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    'Sign up',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.105),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an Account?',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.secondarydark,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Sign in',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
