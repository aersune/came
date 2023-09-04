import 'package:came/home_page.dart';
import 'package:came/methods/provider.dart';
import 'package:came/pages/login_page.dart';
import 'package:came/pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CameProvider()),
  ],child: MyApp(),));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),

            // home: FirebaseAuth.instance.currentUser != null ? HomePage() : LoginPage()

            home: HomePage(),
            // home: FirebaseAuth.instance.currentUser != null ? HomePage() : LoginScreen()


        );
      },
    );
  }
}


