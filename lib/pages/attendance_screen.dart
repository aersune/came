import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';
import '../methods/firestore_methods.dart';
import '../models/user_date.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<UserDate> userCome = [];

  var currentCome = [];
  var _userEnter;
  var _userExit;

  var isCome = false;




  @override
  Widget build(BuildContext context) {
    FirestoreMethods firestoreMedhods = FirestoreMethods();

    // var currentUser = FirebaseAuth.instance.currentUser;
    String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

    String formattedDate = DateFormat('M_d_y').format(DateTime.now());


    var ref =
        FirebaseDatabase.instance.ref("users/$currentUserId/$formattedDate");

    DateTime thisTime = DateTime.now();
    var userEnterHour;
    var _userEnterDay;

    if (_userEnter.runtimeType == DateTime) {
      userEnterHour = DateFormat.Hms().format(_userEnter);
      _userEnterDay = DateFormat('MMMM d').format(_userEnter);
    }

    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Remix.login_box_line),
            ),
            SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Remix.logout_box_line),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black12,
      extendBody: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _userEnter.runtimeType == DateTime
                ? Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 50,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: 100,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                          color: Color(0xff00FF7F),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                userEnterHour.toString(),
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                _userEnterDay,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                // reverse: true,
                shrinkWrap: true,
                itemCount: userCome.length,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  DateTime now = userCome[index].userEnter;
                  String enterHour = DateFormat.Hms().format(now);
                  var enterDay = DateFormat('MMMM d').format(now);

                  DateTime exit = userCome[index].userExit;
                  String exitHour = DateFormat.Hms().format(exit);
                  var exitDay = DateFormat('MMMM d').format(exit);

                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 5, left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          decoration: BoxDecoration(
                              color: Color(0xffDFFF00),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Exit',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    exitHour,
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    exitDay,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          decoration: BoxDecoration(
                              color: Color(0xff00FF7F),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Enter',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 3),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    enterHour,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    enterDay,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
