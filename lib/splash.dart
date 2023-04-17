import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_planner/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      // Navigator.pushReplacementNamed(context, '/dashboard');
      Navigator.pushReplacementNamed(context, '/koroniyo');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //hide appbar

      body: Container(
        // color: Color(0xff1A237E),
        color: AppColors.PrimaryColor,
        // full width and height
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //AssetImage
              Image.asset(
                'images/R_P_Logo.png',
                // width: double.infinity,
                height: 80,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              // Text(
              //   'Dept. of CSE, BU',
              //   style: TextStyle(fontSize: 20, color: Colors.white),
              // ),
              SizedBox(
                height: 25,
              ),
              //circular progress indicator
              CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Developed By: ",
                  style: GoogleFonts.nanumMyeongjo(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      // fontFamily: 'Cursive',
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              Text("Md. Rahat",
                  style: GoogleFonts.nanumMyeongjo(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      // fontFamily: 'Cursive',
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              Text("CSE 5th Batch",
                  style: GoogleFonts.nanumMyeongjo(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      // fontFamily: 'Cursive',
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              Text("University of Barisal",
                  style: GoogleFonts.nanumMyeongjo(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      // fontFamily: 'Cursive',
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
