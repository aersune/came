import 'package:came/home_page.dart';
import 'package:came/pages/register_page.dart';
import 'package:came/utils/colors_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:came/widgets/reusable_widgets.dart';
import 'package:remixicon/remixicon.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

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
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Remix.user_2_fill, size: screenWidth / 4.5, color: Colors.white,),
                SizedBox(height: screenHeight / 55,),
                Text('Вход', style: TextStyle(fontSize: screenWidth / 10, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 8),),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth / 8),
                  child: reusableTextField('Имя пользователя', Remix.user_2_fill, false, _emailController),
                ),
                SizedBox(height: screenHeight / 70,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth / 8),
                  child: reusableTextField('Пароль', Remix.lock_password_fill, true, _passwordController),
                ),
                SizedBox(height: 10,),
                Padding(
                    // wersan@gmail.com
                  // zver1212
                    padding: EdgeInsets.symmetric(horizontal: screenWidth / 8),
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
      ),
    );
  }
  Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Text("Нет аккаунта?",style: TextStyle(
              color: Colors.white70,
          ),),
          SizedBox(width: 5,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            child: Text("Регистрация", style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
          )
      ],
    );
  }
}
