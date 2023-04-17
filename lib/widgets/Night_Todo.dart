//import main.dart
import 'dart:convert';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ramadan_planner/colors.dart';
import 'package:ramadan_planner/Data/data.dart';
//import firebase core and firestore
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import '../Data/localStorageFunc.dart';

class Night_Todo extends StatefulWidget {
  Night_Todo({super.key, required this.ramadan_day});
  int ramadan_day;
  @override
  State<Night_Todo> createState() => _Night_TodoState();
}

class _Night_TodoState extends State<Night_Todo> {
  bool? val = false;
  LocalStorage storage = new LocalStorage('ramadan_planner_1');

  // final CollectionReference _users =
  //     FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Todo list with SwitchListTile widget and a button to add new todo
        Column(children: [
          Card(
              elevation: 5,
              child: Padding(
                  padding:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                  child: Column(children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: EdgeInsets.only(bottom: 5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6)),
                          color: AppColors.PrimaryColor),
                      child: Center(
                        child: Text(
                          "রাত ট্রাকিং:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    // CheckboxListTile

                    for (var i = 0; i < Night_Items.length; i++) ...[
                      CheckboxListTile(
                        secondary: Night_Items[i]['isChecked'] == false
                            ? Icon(
                                Icons.close,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.check,
                                color: AppColors.PrimaryColor,
                              ),
                        activeColor: Night_Items[i]['isChecked'] == false
                            ? Colors.red
                            : AppColors.PrimaryColor,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(Night_Items[i]['title']),
                        isThreeLine: true,
                        subtitle: ExpandableText(
                          Night_Items[i]['subTitle'],
                          expandText: 'show more',
                          collapseText: 'show less',
                          maxLines: 2,
                          linkColor: Colors.blue,
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 12),
                        ),
                        // Text(
                        //   Night_Items[i]['subTitle'],
                        //   style: TextStyle(fontSize: 10),
                        // ),
                        value: Night_Items[i]['isChecked'],
                        onChanged: (newValue) async {
                          Night_Items[i]['isChecked'] = newValue;

                          setState(() {
                            Night_Items[i]['isChecked'] = newValue;
                            setValueToLocalStorage(
                                'Night_Items' + widget.ramadan_day.toString(),
                                json.encode(Night_Items));
                            if (Night_Items.where((e) => e['isChecked'] == true)
                                    .length ==
                                Night_Items.length) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.check_circle,
                                              color: AppColors.PrimaryColor),
                                          SizedBox(width: 2),
                                          Text('জাযাকাল্লহু খইরন!'),
                                        ],
                                      ),
                                      content: Text(
                                          "জাযাকাল্লহু খইরন। আপনি সফলভাবে আজকের রাতের কাজগুলো সম্পন্ন করেছেন! "),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Center(child: Text('ঠিক আছে')),
                                        ),
                                      ],
                                    );
                                  });
                              print("All Done");
                            }

                            storage.setItem(
                                'Night_Items_Count' +
                                    widget.ramadan_day.toString(),
                                Night_Items.where((e) => e['isChecked'] == true)
                                    .length);
                            setState(() {
                              todays_point = Night_Items.where(
                                  (e) => e['isChecked'] == true).length;
                              // _users.add({"name": "Rahat", "price": 23});
                            });
                            print("todays point" + todays_point.toString());
                            print("Day: " + widget.ramadan_day.toString());
                            print(
                                Night_Items.where((e) => e['isChecked'] == true)
                                    .length);
                          });
                        },
                      ),
                    ]
                  ]))),
        ])
      ],
    );
  }
}
