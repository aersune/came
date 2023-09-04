import 'package:came/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import '../utils/colors_utils.dart';
import '../widgets/reusable_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _userEmailIdTextController = TextEditingController();
  TextEditingController _userPasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
              hexStringToColor('039d8f'),
              hexStringToColor('64c987'),
              // hexStringToColor('00938d'),
            ])),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, size.height * 0.2, 20, 0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                reusableTextField('Enter userName', Remix.user_2_fill, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField('Enter Emil Id', Remix.mail_fill, false,
                    _userEmailIdTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField('Enter Password', Remix.lock_password_line,
                    true, _userPasswordTextController),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, false, () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _userEmailIdTextController.text,
                      password: _userPasswordTextController.text).then((value) {
                        print('Created new Accaunt');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  }).onError((error, stackTrace) {
                    print('Error ${error.toString()}');
                  });

                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
