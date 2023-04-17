import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:ramadan_planner/Data/data.dart';
import 'package:ramadan_planner/colors.dart';
import 'package:ramadan_planner/page_1.dart';
import 'package:ramadan_planner/page_2.dart';
import 'package:ramadan_planner/planner.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:ramadan_planner/splash.dart';
import 'package:intl/intl.dart';

import 'initData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Dashboard(),
      initialRoute: '/splash',
      routes: {
        // '/splash': (context) => SplashScreenPage(),
        '/splash': (context) => SplashScreen(),
        '/initData': (context) => initData(),
        '/dashboard': (context) => Dashboard(),
        '/koroniyo': (context) => Koroniyo(),
        '/borjoniyo': (context) => Borjoniyo(),
      },
      //  RamadanPlanner(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<int> ramadanList = List.generate(30, (index) => index + 1);
  var current_month = HijriCalendar.now().getLongMonthName();
  var current_date = HijriCalendar.now().hDay;
  final _random = new Random();
  var todays_ayat;
  var todays_hadith;
  var todays_salaf_qoute;

  //end debug
  @override
  void initState() {
    todays_ayat = AjkerAyat[_random.nextInt(AjkerAyat.length)];
    todays_hadith = AjkerHadith[_random.nextInt(AjkerHadith.length)];
    todays_salaf_qoute = SalafQoutes[_random.nextInt(SalafQoutes.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'রমাদ্বন প্লানার',
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: AppColors.PrimaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(children: [
//asset image  full width of the screen
            // Container(
            //   width: MediaQuery.of(context).size.width * .93,
            //   height: 250,
            //   child: Image.asset(
            //     'images/ramadan.jpg',
            //     fit: BoxFit.contain,
            //   ),
            // ),

            Container(
              // width: MediaQuery.of(context).size.width * .53,
              // height: 250, width: 150,
              child: Column(
                children: [
                  Container(
                    // width: 160,
                    child: Card(
                      elevation: 5.2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              margin: EdgeInsets.only(bottom: 5),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6)),
                                  color: AppColors.PrimaryColor),
                              child: Center(
                                child: Text(
                                  "নির্বাচিত আয়াত",
                                  style: TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            // Divider(
                            //   color: AppColors.PrimaryColor,
                            //   thickness: 1.0,
                            // ),
                            ExpandableText(
                              todays_ayat.toString(),
                              expandText: 'show more',
                              collapseText: 'show less',
                              maxLines: 4,
                              linkColor: Colors.blue,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // width: 180,
                    child: Card(
                      elevation: 5.2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              margin: EdgeInsets.only(bottom: 5),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6)),
                                  color: AppColors.PrimaryColor),
                              child: Center(
                                child: Text(
                                  "নির্বাচিত হাদিস",
                                  style: TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            // Divider(
                            //   color: AppColors.PrimaryColor,
                            //   thickness: 1.0,
                            // ),
                            ExpandableText(
                              todays_hadith.toString(),
                              expandText: 'show more',
                              collapseText: 'show less',
                              maxLines: 4,
                              linkColor: Colors.blue,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // width: 180,
                    child: Card(
                      elevation: 5.2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              margin: EdgeInsets.only(bottom: 5),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6)),
                                  color: AppColors.PrimaryColor),
                              child: Center(
                                child: Text(
                                  "সালাফদের বক্তব্য",
                                  style: TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            // Divider(
                            //   color: AppColors.PrimaryColor,
                            //   thickness: 1.0,
                            // ),
                            ExpandableText(
                              todays_salaf_qoute.toString(),
                              expandText: 'show more',
                              collapseText: 'show less',
                              maxLines: 4,
                              linkColor: Colors.blue,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),

            // Text('Dashboard'),
            // Listtile with Card elevation 5.2 and border radius 10.0
            for (var i = 0; i < ramadanList.length; i++) ...[
              Card(
                elevation: 7.2,
                shape: RoundedRectangleBorder(
                  side: i + 1 <= calculate2023RamdanDate() &&
                          current_month == "Ramadan"
                      ? BorderSide(color: AppColors.PrimaryColor, width: 1)
                      : BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  // border radius with cliprrect  and color with ternary operator
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  tileColor: i + 1 > 20 ? Colors.grey[250] : Colors.white,
                  title: i + 1 == calculate2023RamdanDate() &&
                          current_month == "Ramadan"
                      ? Text('রমাদ্বন - ${ramadanList[i]} (আজ) ')
                      : i + 1 > 20
                          ? Text(
                              'রমাদ্বন - ${ramadanList[i]} ',
                              style: TextStyle(
                                  color: AppColors.PrimaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text('রমাদ্বন - ${ramadanList[i]} '),
                  subtitle: i + 1 > 20
                      ? Text(
                          'রমাদ্বন প্লান করুন',
                          style: TextStyle(
                              color: AppColors.PrimaryColor,
                              fontWeight: FontWeight.bold),
                        )
                      : Text('রমাদ্বন প্লান করুন'),
                  trailing: i + 1 > 20
                      ? i + 1 == 21 ||
                              i + 1 == 23 ||
                              i + 1 == 25 ||
                              i + 1 == 27 ||
                              i + 1 == 29
                          ? Icon(
                              Icons.diamond_rounded,
                              color: AppColors.PrimaryColor,
                            )
                          : Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.PrimaryColor,
                            )
                      : Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RamadanPlanner(ramadan_day: i + 1)),
                    );
                  },
                ),
              ),
            ]
          ]),
        ),
      ),
    );
  }
}
