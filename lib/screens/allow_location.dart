import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:employee_attendance_management/constants.dart';
import 'package:employee_attendance_management/screens/custom_clipper.dart';
import 'package:employee_attendance_management/screens/scan_qr.dart';
import 'package:employee_attendance_management/screens/user_access.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllowLocation extends StatefulWidget {
  final String emplId;
  
  const AllowLocation({
    required this.emplId,
    super.key
  });

  @override
  State<AllowLocation> createState() => _AllowLocationState();
}

class _AllowLocationState extends State<AllowLocation> {

  final obj = Constants();
  double worksiteLatitude = 0;
  double worksiteLongitude = 0;
  double allowedDistanceInMeters = 0; // Allowed radius in meters
  String snackBarMessage = "";

  @override
  void initState() {
    super.initState();
    getWorksiteLocation();
  }

  // Function to get worksite location from DB
  Future<void> getWorksiteLocation() async {
    const String url = "https://schmidivan.com/Fares/employee_attendance_management/get_worksite_location";
    final response = await http.get(Uri.parse("$url?emplId=${widget.emplId}"));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse["success"]) {
        // Process the successful response
        debugPrint("Worksite Latitude: ${jsonResponse["worksite_latitude"]}");
        debugPrint("Worksite Longitude: ${jsonResponse["worksite_longitude"]}");
        debugPrint("Allowed distance in meters: ${jsonResponse["distance_limit"]}");

        worksiteLatitude = jsonResponse["worksite_latitude"].toDouble();
        worksiteLongitude = jsonResponse["worksite_longitude"].toDouble();
        allowedDistanceInMeters = jsonResponse["distance_limit"].toDouble();
      } else {
        // Handle error response
        debugPrint("Error: ${jsonResponse["message"]}");
      }
    } else {
      // Handle HTTP error
      debugPrint("Error: ${response.statusCode}");
    }
  }

  snackBar(String snackBarMessage) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          snackBarMessage
        )
      )
    );
  }

  Future<void> requestLocationPermission(double worksiteLatitude, double worksiteLongitude, double allowedDistanceInMeters) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        snackBarMessage = "Location services are disabled. Please enable location services and try again.";
      });
      debugPrint("Location services are disabled. Please enable location services and try again.");
      snackBar(snackBarMessage);
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          snackBarMessage = "Location permissions are denied. Please allow location permissions and try again.";
        });
        debugPrint("Location permissions are denied. Please allow location permissions and try again.");
        snackBar(snackBarMessage);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        snackBarMessage = "Location permissions are permanently denied, we cannot request permissions. Please enable location permissions and try again.";
      });
      debugPrint("Location permissions are permanently denied, we cannot request permissions. Please enable location permissions and try again.");
      snackBar(snackBarMessage);
      return;
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );

      double distanceInMeters = Geolocator.distanceBetween(
        position.latitude, // Start latitude
        position.longitude, // Start longitude
        worksiteLatitude, // End latitude
        worksiteLongitude // End longitude
      );

      if (distanceInMeters <= allowedDistanceInMeters) {
        debugPrint("Current location matches with the worksite location");
        
        // Navigate to the scan qr page if both the locations match
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ScanQR(emplId: widget.emplId)
        ));
      } else {
        setState(() {
          snackBarMessage = "You are not at the worksite";
        });
        debugPrint("You are not at the worksite");
        snackBar(snackBarMessage);
      }
    } else {
      setState(() {
        snackBarMessage = "Location permissions are denied. Please allow location permissions and try again.";
      });
      debugPrint("Location permissions are denied. Please allow location permissions and try again.");
      snackBar(snackBarMessage);
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
                        onPressed: () => requestLocationPermission(worksiteLatitude, worksiteLongitude, allowedDistanceInMeters),
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

