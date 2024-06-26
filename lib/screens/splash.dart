import 'package:employee_attendance_management/constants.dart';
import 'package:employee_attendance_management/screens/user_access.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final obj = Constants();
  bool alreadyLoggedIn = false;

  @override
  void initState() {
    super.initState();
    alreadyLoggedIn ? navigateToHomePage() : navigateToUserAccessPage(); // Check if user is already logged in
  }

  // Navigate to user access page
  navigateToUserAccessPage() async {
    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => const UserAccess() // Navigate to user access page
    ));
  }

  // Navigate to home page
  navigateToHomePage() async {
    await Future.delayed(const Duration(seconds: 2));

    // Navigator.pushReplacement(context, MaterialPageRoute(
    //   builder: (context) => const Home() // Navigate to home page
    // ));
  }

  @override
  Widget build(BuildContext context) {

    // Device's screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "SCAN",
              style: GoogleFonts.poppins(
                fontSize: screenHeight * 0.05,
                color: obj.darkGray,
                fontWeight: FontWeight.bold,
                letterSpacing: 1
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "P",
                  style: GoogleFonts.poppins(
                    fontSize: screenHeight * 0.05,
                    color: obj.navyBlue,
                    fontWeight: FontWeight.bold
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.02,
                    right: screenWidth * 0.02
                  ),
                  child: Image.asset(
                    "assets/images/focus.png",
                    height: screenWidth * 0.09,
                    color: obj.darkGray
                  )
                ),
                Text(
                  "INT",
                  style: GoogleFonts.poppins(
                    fontSize: screenHeight * 0.05,
                    color: obj.navyBlue,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1
                  )
                )
              ]
            )
          ]
        )
      )
    );
  }
}

