import 'package:employee_attendance_management/constants.dart';
import 'package:employee_attendance_management/screens/id_preference.dart';
import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:google_fonts/google_fonts.dart';

class UserAccess extends StatelessWidget {
  const UserAccess({super.key});

  @override
  Widget build(BuildContext context) {
    
    // Device's screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final obj = Constants();
    String userAccess = "";
    
    return ColorfulSafeArea(
      color: obj.lightGray,
      child: Scaffold(
        backgroundColor: obj.lightGray,
        body: Center(
          child: Container(
            padding: EdgeInsets.all(
              screenWidth * 0.1
            ),
            height: screenHeight * 0.5,
            width: screenWidth * 0.9,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hey,",
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.w700,
                    color: obj.darkGray
                  )
                ),
                SizedBox(
                  height: screenHeight * 0.02
                ),
                Text(
                  "Please select an option to proceed",
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w500,
                    color: obj.darkGray
                  )
                ),
                SizedBox(
                  height: screenHeight * 0.058
                ),

                // Login
                ElevatedButton(
                  onPressed: () {
                    userAccess = "login";
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => IdPreference(userAccess: userAccess) // Navigate to id preference page
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: obj.navyBlue,
                    fixedSize: Size(screenWidth * 0.7, screenHeight * 0.1),
                    shape: const RoundedRectangleBorder()
                  ),
                  child: Text(
                    "Login",
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
            
                // Attendance
                ElevatedButton(
                  onPressed: () {
                    userAccess = "attendance";
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => IdPreference(userAccess: userAccess) // Navigate to id preference page
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: obj.navyBlue,
                    fixedSize: Size(screenWidth * 0.7, screenHeight * 0.1),
                    shape: const RoundedRectangleBorder()
                  ),
                  child: Text(
                    "Attendance",
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
        )
      )
    );
  }
}

