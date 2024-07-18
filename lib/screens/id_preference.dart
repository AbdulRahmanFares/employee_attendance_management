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
      color: obj.lightGray,
      child: Scaffold(
        backgroundColor: obj.lightGray,
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: screenHeight,
              width: screenWidth
            ),
            Container(
              padding: EdgeInsets.all(
                screenWidth * 0.1
              ),
              height: screenHeight * 0.5,
              width: screenWidth * 0.9,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    userAccess == "login"
                      ? "Your preferred Id for login"
                      : "Your preferred Id for attendance",
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w500,
                      color: obj.darkGray
                    )
                  ),
                  SizedBox(
                    height: screenWidth * 0.1
                  ),
                  SizedBox(
                    height: screenHeight * 0.328,
                    width: screenWidth * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Mobile number
                        ElevatedButton(
                          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => FetchMobileNumber(userAccess: userAccess) // Navigate to fetch mobile number page
                          )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: obj.navyBlue,
                            fixedSize: Size(screenWidth * 0.3, screenHeight * 0.25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.05)
                            )
                          ),
                          child: Text(
                            "Mobile",
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.04,
                              color: Colors.white,
                              letterSpacing: 1
                            )
                          )
                        ),

                        // Employee id
                        ElevatedButton(
                          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => EmployeeId(userAccess: userAccess) // Navigate to employee id page
                          )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: obj.navyBlue,
                            fixedSize: Size(screenWidth * 0.3, screenHeight * 0.25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.05)
                            )
                          ),
                          child: Text(
                            "Id",
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
                ]
              )
            ),

            // Back button
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

