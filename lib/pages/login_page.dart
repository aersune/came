import 'package:came/home_page.dart';
import 'package:came/pages/register_page.dart';
import 'package:came/utils/colors_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:came/widgets/reusable_widgets.dart';
import 'package:remixicon/remixicon.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [

            hexStringToColor('039d8f'),
            hexStringToColor('64c987'),
            hexStringToColor('00938d'),

          ],

          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 8),),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: reusableTextField('Enter userName', Remix.user_2_fill, false, _emailController),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: reusableTextField('password', Remix.lock_password_fill, true, _passwordController),
              ),
              SizedBox(height: 20,),
              Padding(
                  // wersan@gmail.com
                // zver1212
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: signInSignUpButton(context, true, (){
                    FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    }).onError((error, stackTrace) {
                      print('Error login ${error.toString()}');
                    });
                  })),
              signUpOption(),
            ],
          ),
        ),
      ),
    );
  }
  Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Text("Don't have accaunt?",style: TextStyle(
              color: Colors.white70,

          ),),
          SizedBox(width: 5,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            child: Text("Sign Up", style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
          )
      ],
    );
  }
}
