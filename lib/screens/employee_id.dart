import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:employee_attendance_management/constants.dart';
import 'package:employee_attendance_management/screens/allow_location.dart';
import 'package:employee_attendance_management/screens/custom_clipper.dart';
import 'package:employee_attendance_management/screens/id_preference.dart';
import 'package:employee_attendance_management/screens/password.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployeeId extends StatefulWidget {
  final String userAccess;
  
  const EmployeeId({
    required this.userAccess,
    super.key
  });

  @override
  State<EmployeeId> createState() => _EmployeeIdState();
}

class _EmployeeIdState extends State<EmployeeId> {

  final obj = Constants();
  TextEditingController employeeIdController = TextEditingController();
  String idPreference = "employeeId";
  String emplId = "";
  String password = "";
  late Color validationColor;

  @override
  void initState() {
    super.initState();
    validationColor = obj.darkGray;
  }

  // Function to verify employee Id and get password from DB
  Future<void> verifyEmployeeId() async {
    emplId = employeeIdController.text;
    const String url = "https://schmidivan.com/Fares/employee_attendance_management/get_password";
    final response = await http.get(Uri.parse("$url?id=$emplId&idPreference=$idPreference"));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse["success"]) {
        // Process the successful response
        debugPrint("Password: ${jsonResponse["password"]}");

        password = jsonResponse["password"];

        if (widget.userAccess == "login") {
          // Navigate to the password page with the fetched emplId and password
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Password(userAccess: widget.userAccess, idPreference: idPreference, emplId: emplId, password: password)
          ));
        } else {
          // Navigate to the allow location page with the fetched emplId
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => AllowLocation(emplId: emplId)
          ));
        }
      } else {
        // Handle error response
        debugPrint("Error: ${jsonResponse["message"]}");

        setState(() {
          validationColor = Colors.red;
        });
      }
    } else {
      // Handle HTTP error
      debugPrint("Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    
    // Device's screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ColorfulSafeArea(
      color: obj.darkGray,
      child: Scaffold(
        backgroundColor: obj.darkGray,
        body: Stack(
          children: [
            Container(
              color: obj.darkGray
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => IdPreference(userAccess: widget.userAccess) // Navigate to id preference page
                )),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: screenWidth * 0.07
                )
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: LoginProcessTileClipper(),
                child: Container(
                  padding: EdgeInsets.only(
                    top: screenWidth * 0.1,
                    left: screenWidth * 0.05
                  ),
                  height: screenHeight * 0.7,
                  width: screenWidth,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // First vertical line
                      Container(
                        margin: EdgeInsets.only(
                          bottom: screenWidth * 0.05
                        ),
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.01,
                        color: obj.darkGray
                      ),
                      Text(
                        "EMPLOYEE ID",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.08,
                          color: obj.darkGray,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2
                        )
                      ),
                      Text(
                        "Please enter your id for verification",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          color: obj.darkGray,
                          fontWeight: FontWeight.w500
                        )
                      ),

                      // Second vertical line
                      Container(
                        margin: EdgeInsets.only(
                          top: screenWidth * 0.05,
                          bottom: screenWidth * 0.1
                        ),
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.01,
                        color: obj.darkGray
                      ),

                      // Employee id
                      Container(
                      margin: EdgeInsets.only(
                        bottom: screenWidth * 0.1,
                        right: screenWidth * 0.05
                      ),
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.1,
                        right: screenWidth * 0.1
                      ),
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: validationColor
                        )
                      ),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: employeeIdController,
                        maxLines: 1,
                        cursorColor: Colors.cyan,
                        keyboardType: TextInputType.emailAddress,

                        // User input style
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.05,
                          color: obj.darkGray,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2
                        ),

                        decoration: const InputDecoration(
                          border: InputBorder.none // Remove the underline
                        )
                      )
                    ),

                      // Verify button
                      ElevatedButton(
                        onPressed: () => verifyEmployeeId(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: obj.navyBlue,
                          fixedSize: Size(screenWidth * 0.9, screenHeight * 0.1),
                          shape: const RoundedRectangleBorder()
                        ),
                        child: Text(
                          "Verify Id",
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
          ]
        )
      )
    );
  }
}

