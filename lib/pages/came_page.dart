import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../methods/firestore_methods.dart';
import '../methods/provider.dart';
import '../models/user_date.dart';

class CamePage extends StatefulWidget {
  @override
  State<CamePage> createState() => _CamePageState();
}

class _CamePageState extends State<CamePage> {
  List<UserDate> userCome = [];

  var currentCome = [];
  var _userEnter;
  var _userExit;


  var isCome = false;

  @override
  Widget build(BuildContext context) {

    FirestoreMethods firestoreMedhods = FirestoreMethods();
    var ref = Provider.of<CameProvider>(context).ref;

    DateTime thisTime = DateTime.now();
    var userEnterHour;
    var _userEnterDay;


    if(_userEnter.runtimeType == DateTime){

      userEnterHour = DateFormat.Hms().format(_userEnter);
      _userEnterDay = DateFormat('MMMM d').format(_userEnter);
    }





    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isCome = !isCome;
                if(_userEnter == null){
                  _userEnter = thisTime;
                  print(_userEnter);
                } else if(_userEnter.runtimeType == DateTime && _userExit == null){
                  _userExit = thisTime;
                  print('$_userEnter ---- $_userExit');
                }
                else if(_userEnter.runtimeType == DateTime &&  _userExit.runtimeType == DateTime){

                  _userEnter = null;
                  _userExit = null;
                  print('$_userEnter ---- $_userExit');
                }




                if (currentCome.length <= 2) {
                  currentCome.add(thisTime);
                }
                if (currentCome.length == 2) {
                  userCome.add(UserDate(
                      userEnter: currentCome[0], userExit: currentCome[1]));
                  firestoreMedhods.addData(ref, _userEnter.toString(), _userExit.toString());
                  currentCome.clear();
                }
              });
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.blue),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      backgroundColor: Colors.black12,
      extendBody: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [

            _userEnter.runtimeType == DateTime ?
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              margin: EdgeInsets.only(left: 10, right: 10, top: 50,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
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
            ) :
                SizedBox(),

            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                // reverse: true,
                shrinkWrap: true,
                itemCount: userCome.length,
                itemBuilder: (BuildContext context, int index, ) {
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
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          margin:
                          EdgeInsets.fromLTRB(10, 5, 10, 5),
                          padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                          margin:
                          EdgeInsets.fromLTRB(10, 5, 10, 5),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

    );

  }

}
