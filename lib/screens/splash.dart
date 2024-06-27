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
        child: Container(
          height: screenHeight * 0.08,
          width: screenWidth * 0.35,
          decoration: BoxDecoration(
            border: Border.all(
              color: obj.darkGray
            )
          ),
          alignment: Alignment.center,
          child: Text(
            "LOGO",
            style: GoogleFonts.poppins(
              fontSize: screenHeight * 0.04,
              color: obj.navyBlue,
              fontWeight: FontWeight.bold,
              letterSpacing: 2
            )
          )
        )
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          bottom: screenHeight * 0.02
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Powered by ",
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.04,
                color: obj.darkGray,
                fontWeight: FontWeight.w500,
                letterSpacing: 1
              )
            ),
            Image.asset(
              "assets/images/lead.png",
              height: screenWidth * 0.07
            )
          ]
        )
      )
    );
  }
}

