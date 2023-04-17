//import material dart package
import 'package:flutter/material.dart';
import 'package:ramadan_planner/splash.dart';

import 'main.dart';

class initData extends StatefulWidget {
  const initData({super.key});

  @override
  State<initData> createState() => _initDataState();
}

class _initDataState extends State<initData> {
  Future<bool> doSomeWait() {
    return Future.delayed(Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        doSomeWait(),
      ]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return SplashScreen();

        ///Splash Screen
        else
          return
              // Text(storage.getItem("Student_list").toString());
              Dashboard();

        ///Main Screen
      },
    );
  }
}
