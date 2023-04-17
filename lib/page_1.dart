//import material dart package
import 'package:flutter/material.dart';
import 'package:ramadan_planner/Data/data.dart';
import 'package:ramadan_planner/colors.dart';

class Koroniyo extends StatefulWidget {
  const Koroniyo({super.key});

  @override
  State<Koroniyo> createState() => _KoroniyoState();
}

class _KoroniyoState extends State<Koroniyo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "রমাদ্বনে করণীয়",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: AppColors.PrimaryColor,
            //action button
            actions: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(2, 0, 10, 0),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.pushNamed(context, '/borjoniyo');
                  },
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                // a list of what to do in the morning full design
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    margin: EdgeInsets.only(bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6)),
                    ),
                    child: Center(
                      child: Text(
                        "পরবর্তী পেইজে যেতে নিচে স্ক্রল করে 'পরবর্তী পৃষ্ঠা দেখুন' পেইজে ক্লিক করুন",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: AppColors.PrimaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  for (var i = 0; i < koroniyo_list.length; i++) ...[
                    Card(
                      elevation: 3.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.wb_sunny),
                        title: Text(koroniyo_list[i]),
                        // subtitle: Text("সকালের কাজ করুন"),
                      ),
                    ),
                  ],
                  // elevated button for next page
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        margin: EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.PrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            primary: AppColors.PrimaryColor,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/borjoniyo');
                          },
                          child: Text("পরবর্তী পৃষ্ঠা দেখুন"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
