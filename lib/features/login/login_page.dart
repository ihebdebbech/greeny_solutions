// ignore_for_file: prefer_const_constructors

import 'package:core/utils/media_query_height.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny_solution/features/login/login_controler.dart';
import 'package:greeny_solution/features/login/widgets/login_form.dart';
import 'package:shared/shared.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  PopScope(
     canPop: false,
      child:  Scaffold(
      
      
      resizeToAvoidBottomInset:
          true, // Ensure the layout adjusts when the keyboard appears
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.topEnd,
            colors: [
              AppColors.primary,   // Start color
               //Color.fromARGB(255, 10, 78, 50)
               Color.fromARGB(255, 12, 87, 56) // End color
            ],
          ),
        ),
        child: Stack(
        children: [
          Positioned(
            top: context.Heightmedia(0.094),
            left:context.widthmedia(0.26),
            child: Image.asset(
              'assets/Images/greenywhite.png',
              width: context.widthmedia(0.45),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
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
    ),
      ),
    );
  }
}
