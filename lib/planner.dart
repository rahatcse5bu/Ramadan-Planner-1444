import 'dart:convert';
import 'dart:math';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:ramadan_planner/Data/data.dart';
import 'package:ramadan_planner/colors.dart';
import 'package:ramadan_planner/widgets/Dhur_Todo.dart';
import 'package:ramadan_planner/widgets/Evening_Todo.dart';
import 'package:ramadan_planner/widgets/General_Todo.dart';
import 'package:ramadan_planner/widgets/Good_Afternoon_Todo.dart';
import 'package:ramadan_planner/widgets/Night_Todo.dart';
import 'package:ramadan_planner/widgets/Fajr_Todo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
//import duhr todo
import 'package:ramadan_planner/widgets/Dhur_Todo.dart';
import 'package:ramadan_planner/widgets/Qadr_Todo.dart';

class RamadanPlanner extends StatefulWidget {
  RamadanPlanner({super.key, required this.ramadan_day});
  int ramadan_day;

  @override
  State<RamadanPlanner> createState() => _RamadanPlannerState();
}

class _RamadanPlannerState extends State<RamadanPlanner> {
  var current_month = HijriCalendar.now().getLongMonthName();
  var current_date = HijriCalendar.now().hDay;
  var current_year = HijriCalendar.now().hYear;
  final _random = new Random();
  // var todays_point = 0;
  var endName = 0;
  var startName = 0;
  TextEditingController special_achievemnt_controller =
      new TextEditingController();
  LocalStorage storage = new LocalStorage('ramadan_planner_1');
  var todays_dua;
  var todays_ayat;
  var todays_hadith;
  //override inistate
  @override
  void initState() {
    todays_dua = Dua_Items[_random.nextInt(Dua_Items.length)];
    todays_ayat = AjkerAyat[_random.nextInt(AjkerAyat.length)];
    todays_hadith = AjkerHadith[_random.nextInt(AjkerHadith.length)];
    endName = widget.ramadan_day * 3;
    startName = endName - 3;
    super.initState();

    storage.ready.then((value) {
      if (storage
              .getItem('special_achievement' + widget.ramadan_day.toString()) !=
          null) {
        special_achievemnt_controller.text = storage
            .getItem('special_achievement' + widget.ramadan_day.toString());
      } else {
        special_achievemnt_controller.text = "";
      }

      for (var i = 0; i < Good_Afternoon_Items_inputs.length; i++) {
        if (storage.getItem('Good_Afternoon_Items_inputs_' +
                widget.ramadan_day.toString() +
                "_" +
                i.toString()) !=
            null) {
          print('Good_Afternoon_Items_inputs_' +
              widget.ramadan_day.toString() +
              "_" +
              i.toString());
          Good_Afternoon_Items_inputs[i]['controller'].text = storage.getItem(
              'Good_Afternoon_Items_inputs_' +
                  widget.ramadan_day.toString() +
                  "_" +
                  i.toString());
        } else {
          Good_Afternoon_Items_inputs[i]['controller'].text = "";
        }
      }

//Night Item Starts
      if (storage.getItem('Night_Items' + widget.ramadan_day.toString()) !=
          null) {
        List<Map<String, dynamic>> Night_Items1 =
            storage.getItem('Night_Items' + widget.ramadan_day.toString()) ==
                    null
                ? []
                : List<Map<String, dynamic>>.from(json.decode(storage
                    .getItem('Night_Items' + widget.ramadan_day.toString())));

        // print("Hello Rahat");
        // print(Night_Items1.runtimeType);
        if (storage
                .getItem('Night_Items_Count' + widget.ramadan_day.toString()) !=
            null) {
          print(storage
              .getItem('Night_Items_Count' + widget.ramadan_day.toString()));
        } else {
          print(Night_Items.where((e) => e['isChecked'] == true).length);
        }
        // print(storage.getItem(
        //     'Night_Items_Count' + widget.ramadan_day.toString(),
        //     Night_Items.where((e) => e['isChecked'] == true).length));
        setState(() {
          Night_Items = Night_Items1;
        });
      } else {
        setState(() {
          for (var i = 0; i < Night_Items.length; i++) {
            Night_Items[i]['isChecked'] = false;
          }
        });
      }

//Fazr Sectio Starts
      if (storage.getItem('Fajr_Items' + widget.ramadan_day.toString()) !=
          null) {
        List<Map<String, dynamic>> Fajr_Items1 = storage
                    .getItem('Fajr_Items' + widget.ramadan_day.toString()) ==
                null
            ? []
            : List<Map<String, dynamic>>.from(json.decode(
                storage.getItem('Fajr_Items' + widget.ramadan_day.toString())));

        // print("Hello Rahat");
        // print(Fajr_Items1.runtimeType);
        setState(() {
          Fajr_Items = Fajr_Items1;
        });
      } else {
        setState(() {
          for (var i = 0; i < Fajr_Items.length; i++) {
            Fajr_Items[i]['isChecked'] = false;
          }
        });
      }

      //END Fazr Section

//Dhuhr Sectio Starts
      if (storage.getItem('Dhuhr_Items' + widget.ramadan_day.toString()) !=
          null) {
        List<Map<String, dynamic>> Dhuhr_Items1 =
            storage.getItem('Dhuhr_Items' + widget.ramadan_day.toString()) ==
                    null
                ? []
                : List<Map<String, dynamic>>.from(json.decode(storage
                    .getItem('Dhuhr_Items' + widget.ramadan_day.toString())));

        // print("Hello Rahat");

        setState(() {
          Dhuhr_Items = Dhuhr_Items1;
        });
      } else {
        setState(() {
          for (var i = 0; i < Dhuhr_Items.length; i++) {
            Dhuhr_Items[i]['isChecked'] = false;
          }
        });
      }

      //END Dhuhr Section

//Good_Afternoon Sectio Starts
      if (storage.getItem(
              'Good_Afternoon_Items' + widget.ramadan_day.toString()) !=
          null) {
        List<Map<String, dynamic>> Good_Afternoon_Items1 = storage.getItem(
                    'Good_Afternoon_Items' + widget.ramadan_day.toString()) ==
                null
            ? []
            : List<Map<String, dynamic>>.from(json.decode(storage.getItem(
                'Good_Afternoon_Items' + widget.ramadan_day.toString())));

        // print("Hello Rahat");

        setState(() {
          Good_Afternoon_Items = Good_Afternoon_Items1;
        });
      } else {
        setState(() {
          for (var i = 0; i < Good_Afternoon_Items.length; i++) {
            Good_Afternoon_Items[i]['isChecked'] = false;
          }
        });
      }

      //END Good_Afternoon Section

//Evening_Items Section Starts
      if (storage.getItem('Evening_Items' + widget.ramadan_day.toString()) !=
          null) {
        List<Map<String, dynamic>> Evening_Items1 =
            storage.getItem('Evening_Items' + widget.ramadan_day.toString()) ==
                    null
                ? []
                : List<Map<String, dynamic>>.from(json.decode(storage
                    .getItem('Evening_Items' + widget.ramadan_day.toString())));

        // print("Hello Rahat");

        setState(() {
          Evening_Items = Evening_Items1;
        });
      } else {
        setState(() {
          for (var i = 0; i < Evening_Items.length; i++) {
            Evening_Items[i]['isChecked'] = false;
          }
        });
      }

      //END Evening_Items Section

//General Section Starts
      if (storage.getItem('General_Items' + widget.ramadan_day.toString()) !=
          null) {
        List<Map<String, dynamic>> General_Items1 =
            storage.getItem('General_Items' + widget.ramadan_day.toString()) ==
                    null
                ? []
                : List<Map<String, dynamic>>.from(json.decode(storage
                    .getItem('General_Items' + widget.ramadan_day.toString())));

        // print("Hello Rahat");

        setState(() {
          General_Items = General_Items1;
        });
      } else {
        setState(() {
          for (var i = 0; i < General_Items.length; i++) {
            General_Items[i]['isChecked'] = false;
          }
        });
      }

      //END Evening_Items Section

//Qadr Section Starts
      if (storage.getItem('Qadr_Data' + widget.ramadan_day.toString()) !=
          null) {
        List<Map<String, dynamic>> Qadr_Data1 = storage
                    .getItem('Qadr_Data' + widget.ramadan_day.toString()) ==
                null
            ? []
            : List<Map<String, dynamic>>.from(json.decode(
                storage.getItem('Qadr_Data' + widget.ramadan_day.toString())));

        // print("Hello Rahat");

        setState(() {
          Qadr_Data = Qadr_Data1;
        });
      } else {
        setState(() {
          for (var i = 0; i < Qadr_Data.length; i++) {
            Qadr_Data[i]['isChecked'] = false;
          }
        });
      }

      //END Qadr Section

      // todays_point = CalculateTodaysPoints();
    });
  }

  @override
  Widget build(BuildContext context) {
    var yearAH;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PrimaryColor,
        title: Text('${widget.ramadan_day} রমাদ্বন ${current_year}'),
        centerTitle: true,
      ),
      body:

//checklist tile widget

          SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              //Arabic Date Today Widge Text Widget for the date
              SizedBox(
                height: 10,
              ),

              Card(
                child: Container(
                  // color: AppColors.PrimaryColor,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6)),
                    color: AppColors.PrimaryColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        // "আপনার আজকের পয়েন্ট: ${storage.getItem('Night_Items_Count' + widget.ramadan_day.toString())}",
                        "আজকের পয়েন্ট: $todays_point",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              // 2 columns with card  for hadith and ayat of the day
              Column(
                children: [
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10),
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
                                "আজকের হাদিস",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          // Divider(
                          //   color: AppColors.PrimaryColor,
                          //   height: 10,
                          //   thickness: 1,
                          //   // indent: 20,
                          //   // endIndent: 20,
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
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10),
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
                                "আজকের আয়াত",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),

                          ExpandableText(
                            todays_ayat.toString(),
                            expandText: 'show more',
                            collapseText: 'show less',
                            maxLines: 4,
                            linkColor: Colors.blue,
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 12),
                          ),

                          // Text(
                          //     "The Messenger of Allah (ﷺ) said: ‘Whoever prays the night prayer in Ramadan out of sincere faith and hoping to attain Allah’s rewards, then all his previous sins will be forgiven.’"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Night_Todo(ramadan_day: widget.ramadan_day),
              Qadr_Todo(ramadan_day: widget.ramadan_day),
              Fajr_Todo(ramadan_day: widget.ramadan_day),
              Dhuhr_Todo(ramadan_day: widget.ramadan_day),
              // column for dua of the day
              Column(
                children: [
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10),
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
                                "আজকের দু'আ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            todays_dua['title'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpandableText(
                            todays_dua['subTitle'].toString(),
                            expandText: 'show more',
                            collapseText: 'show less',
                            maxLines: 4,
                            linkColor: Colors.blue,
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 12),
                          ),
                          // Text(
                          //     "The Messenger of Allah (ﷺ) said: ‘Whoever prays the night prayer in Ramadan out of sincere faith and hoping to attain Allah’s rewards, then all his previous sins will be forgiven.’"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              General_Todo(ramadan_day: widget.ramadan_day),
              Good_Afternoon_Todo(ramadan_day: widget.ramadan_day),
              Evening_Todo(ramadan_day: widget.ramadan_day),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.only(bottom: 5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60)),
                    color: AppColors.PrimaryColor),
                child: Center(
                    child: Text("আসমাউল হুসনা:",
                        style: TextStyle(fontSize: 25, color: Colors.white))),
              ),

              // a table widget with the name of Allah and the meaning of the name
              Container(
                margin: EdgeInsets.all(10),
                child: Table(
                  border: TableBorder.all(
                      color: AppColors.PrimaryColor,
                      width: 1,
                      style: BorderStyle
                          .solid, //tablerow margin 10 from top and bottom
                      borderRadius: BorderRadius.circular(5)),

                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  //tablerow margin 10 from top and bottom and 5 from left and

                  children: [
                    for (var name = startName; name < endName; name++) ...[
                      TableRow(children: [
                        Center(
                            child: Text(
                          Asmaul_Husna[name],
                          style: TextStyle(fontSize: 20),
                        ))
                      ]),
                    ],
                  ],
                ),
              ),
              //column for special achievements with textinputfield textarea
              Column(
                children: [
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
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
                                "বিশেষ অর্জন",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            // initialValue:
                            //     storage.getItem("special_achievement") != null
                            //         ? storage.getItem("special_achievement")
                            //         : "",
                            controller: special_achievemnt_controller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'আপনার বিশেষ অর্জন টাইপ করুন...',
                            ),
                            maxLines: 5,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.PrimaryColor),
                            ),
                            onPressed: () async {
                              storage.setItem(
                                  "special_achievement" +
                                      widget.ramadan_day.toString(),
                                  special_achievemnt_controller.text);
                              Fluttertoast.showToast(
                                  msg: "আপনার তথ্য সংরক্ষণ করা হয়েছে",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            },
                            child: Text(
                              'আপনার অর্জন সাবমিট করুন',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Evening_Todo()
            ],
          ),
        ),
      ),
    );
  }
}
