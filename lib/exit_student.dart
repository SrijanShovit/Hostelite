import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:hostelite/home_screen_Admin.dart';
import 'package:hostelite/home_screen_Student.dart';
import 'package:hostelite/models/user_model.dart';
import 'package:hostelite/shared_files/decoration.dart';

class MarkingExit extends StatefulWidget {
  const MarkingExit({Key key}) : super(key: key);

  @override
  _MarkingExitState createState() => _MarkingExitState();
}

Dialog leadDialog = Dialog(
  child: Container(
    height: 300,
    width: 360,
    child: Column(
      children: <Widget>[
        Center(
          child: Image(
            image: AssetImage('assets/create_account_page/Vector.png'),
            height: 150,
            width: 150,
          ),
        ),
        Text('Entry Marked',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('Successfully',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        Container(
          width: 150.0,
          height: 40.0,
          child: MaterialButton(
            child: Text('Done',style: TextStyle(color: Colors.white,fontSize: 17.0),),
            color: Colors.pinkAccent[100],
            minWidth: 100.0,

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),

            onPressed: () {
              BuildContext context;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return HomeScreenStudent();
                      }
                  )
              );
            },
          ),
        ),
      ],
    ),
  ),
);

class _MarkingExitState extends State<MarkingExit> {

  String roomNumber;
  String rollNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Mark Entry',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
        elevation: 10,
        backgroundColor: Color(0xffFE96FA)
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/second_page/Group 33694.png'),
                  fit: BoxFit.contain
              )
          ),
          child: Column(
            children: <Widget>[
              Card(
                child: TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Room No.'),
                    onChanged: (value) {
                      setState(() {
                        rollNumber = value.trim();
                      });
                    }),
              ),
              Card(
                child: TextFormField(

                    decoration: textInputDecoration.copyWith(hintText: 'Roll No.'),
                    onChanged: (value){
                      setState(() {
                        roomNumber = value.trim();
                      });}
                ),
              ),
              // Card(
              //   child: TextFormField(
              //     decoration: textInputDecoration.copyWith(hintText: 'Hostel Name'),
              //     onChanged: (value){
              //       setState(() {
              //         hostelName = value.trim();
              //       });}
              /*value: _myActivity,
                  onSaved: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },*/
              //   )
              // ),
              SizedBox(height: 80),
              Container(
                width: 130,
                height: 50,
                child: MaterialButton(
                  child: Text('Mark Entry',

                    style: TextStyle(color: Colors.black87, fontSize: 15),
                  ),
                  color: Colors.pinkAccent,
                  minWidth: 100,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () async {

                    FirebaseFirestore.instance.
                    collection("studentUsers").
                    doc(FirebaseAuth.instance.currentUser.uid).
                    collection("exit").
                    doc(FirebaseAuth.instance.currentUser.uid).
                    set({
                      // "hostelName" : hostelName,
                      "rollNumber" :rollNumber,
                      "roomNumber" : roomNumber,
                      "userUid" : FirebaseAuth.instance.currentUser.uid,
                      "time" : DateTime.now().toString()
                    });

                    showDialog(
                        context: context,
                        // ignore: non_constant_identifier_names
                        builder: (BuildContext) => leadDialog
                    );

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );;
  }
}