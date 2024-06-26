import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:employee_attendance_management/constants.dart';
import 'package:employee_attendance_management/screens/employee_id.dart';
import 'package:employee_attendance_management/screens/fetch_mobile_number.dart';
import 'package:employee_attendance_management/screens/user_access.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IdPreference extends StatelessWidget {
  final String userAccess;

  const IdPreference({
    required this.userAccess,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    
    // Device's screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final obj = Constants();
    
    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/id_preference_bg.jpg"
                  ),
                  fit: BoxFit.fill
                )
              )
            ),
            Center(
              child: Container(
                height: screenHeight * 0.5,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.1)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Choose your preferred login Id",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.04,
                        color: obj.darkGray,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    SizedBox(
                      height: screenHeight * 0.05
                    ),

                    // Mobile number
                    ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => FetchMobileNumber(userAccess: userAccess) // Navigate to fetch mobile number page
                      )),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: obj.navyBlue,
                        fixedSize: Size(screenWidth * 0.8, screenHeight * 0.1),
                        shape: const RoundedRectangleBorder()
                      ),
                      child: Text(
                        "Mobile Number",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          color: Colors.white,
                          letterSpacing: 1
                        )
                      )
                    ),
                    SizedBox(
                      height: screenHeight * 0.05
                    ),
                
                    // Employee id
                    ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => EmployeeId(userAccess: userAccess) // Navigate to employee id page
                      )),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: obj.navyBlue,
                        fixedSize: Size(screenWidth * 0.8, screenHeight * 0.1),
                        shape: const RoundedRectangleBorder()
                      ),
                      child: Text(
                        "Employee Id",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          color: Colors.white,
                          letterSpacing: 1
                        )
                      )
                    )
                  ]
                )
              )
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => const UserAccess() // Navigate to user access page
                )),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: obj.darkGray,
                  size: screenWidth * 0.07
                )
              )
            )
          ]
        )
      )
    );
  }
}

