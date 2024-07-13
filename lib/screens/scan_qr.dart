import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:employee_attendance_management/constants.dart';
import 'package:employee_attendance_management/screens/confirmation.dart';
import 'package:employee_attendance_management/screens/custom_clipper.dart';
import 'package:employee_attendance_management/screens/user_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScanQR extends StatefulWidget {
  final String emplId;

  const ScanQR({
    required this.emplId,
    super.key
  });

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {

  final obj = Constants();
  String qrCode = "";

  @override
  void initState() {
    super.initState();
    getQRCode();
  }

  // Platform messages are asynchronous, so we initialize in an async method
  Future<void> scanQR(String qrCode) async {
    String qrScanResult = ""; // Initialize with an empty string

    // Platform messages may fail, so we use a try / catch PlatformException
    try {
      qrScanResult = await FlutterBarcodeScanner.scanBarcode(
        "#1A237E", // Line color
        "CANCEL", // Cancel button text
        true, // Show flash icon
        ScanMode.QR // Scan mode
      );
      debugPrint("QR code: $qrCode");
      debugPrint("QR scan result: $qrScanResult");
    } on PlatformException catch (e) {
      debugPrint("Failed to scan qr because of ${e.message}");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance

    if (!mounted) return;

    // Navigate to the confirmation page if the qr scan result matches with the qr code
    if (qrScanResult == qrCode) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Confirmation(emplId: widget.emplId)
      ));
    } else {
      // Show an error message if the qr scan result doesn't match with the qr code
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Invalid QR code")
      ));

      debugPrint("QR code does not match");
    }

    setState(() {});
  }

  // Function to get qr code from DB
  Future getQRCode() async {
    const String url = "https://schmidivan.com/Fares/employee_attendance_management/get_qr_code";
    final response = await http.get(Uri.parse("$url?emplId=${widget.emplId}"));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse["success"]) {
        // Process the successful response
        debugPrint("QR Code: ${jsonResponse["qr_code"]}");

        qrCode = jsonResponse["qr_code"];
        return qrCode;
      } else {
        // Handle error response
        debugPrint("Error: ${jsonResponse["message"]}");

        qrCode = jsonResponse["message"];
        return qrCode;
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
                        "SCAN QR",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.08,
                          color: obj.darkGray,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2
                        )
                      ),
                      Text(
                        "Please scan the qr to proceed",
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

                      // Scan button
                      ElevatedButton(
                        onPressed: () => scanQR(qrCode),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: obj.navyBlue,
                          fixedSize: Size(screenWidth * 0.9, screenHeight * 0.1),
                          shape: const RoundedRectangleBorder()
                        ),
                        child: Text(
                          "Scan",
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

