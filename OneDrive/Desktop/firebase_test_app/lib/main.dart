import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test_app/screens/home_screen.dart';
import 'package:firebase_test_app/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth_App',
      home: FutureBuilder<User?>(future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context , snapshot){

      if(snapshot.hasData){
        return const HomeScreen();
      }
      else{
        return const SigninScreen();
      }
      }
      
    ));
  }
}