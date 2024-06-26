import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:employee_attendance_management/constants.dart';
import 'package:employee_attendance_management/screens/custom_clipper.dart';
import 'package:employee_attendance_management/screens/scan_qr.dart';
import 'package:employee_attendance_management/screens/user_access.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class AllowLocation extends StatefulWidget {
  final String idPreference;
  final String id;
  
  const AllowLocation({
    required this.idPreference,
    required this.id,
    super.key
  });

  @override
  State<AllowLocation> createState() => _AllowLocationState();
}

class _AllowLocationState extends State<AllowLocation> {

  final obj = Constants();

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
          permission = await Geolocator.requestPermission();
        }
    
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => ScanQR(idPreference: widget.idPreference, id: widget.id) // Navigate to scan qr page
          ));
        } else {
          // Permission denied or permanently denied
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Please allow location access to proceed",
                style: GoogleFonts.poppins()
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Ok",
                    style: GoogleFonts.poppins()
                  )
                )
              ]
            )
          );
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
                        "ALLOW LOCATION",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.08,
                          color: obj.darkGray,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2
                        )
                      ),
                      Text(
                        "Please allow location access to proceed",
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

                      // Allow location button
                      ElevatedButton(
                        onPressed: () => requestLocationPermission(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: obj.navyBlue,
                          fixedSize: Size(screenWidth * 0.9, screenHeight * 0.1),
                          shape: const RoundedRectangleBorder()
                        ),
                        child: Text(
                          "Allow Location",
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.04,
                            color: Colors.white,
                            letterSpacing: 1
                          )
                        )
                      ),
                      SizedBox(
                        height: screenWidth * 0.1
                      ),

                      // Come back later button
                      ElevatedButton(
                        onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => const UserAccess() // Navigate to user access page
                        )),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: obj.navyBlue,
                          fixedSize: Size(screenWidth * 0.9, screenHeight * 0.1),
                          shape: const RoundedRectangleBorder()
                        ),
                        child: Text(
                          "Come Back Later",
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

