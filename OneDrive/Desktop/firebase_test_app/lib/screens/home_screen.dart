import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test_app/screens/signin_screen.dart';
class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});

Future<void> _logout(BuildContext context) async{
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SigninScreen()
  ),
  );

}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(onPressed: (){
            _logout(context);
          }

          
          
          , child: Text('Log Out'),
        ),
      ),
    ));
  }
}