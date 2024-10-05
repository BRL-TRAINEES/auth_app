import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test_app/screens/home_screen.dart';
import 'package:firebase_test_app/screens/reset_password-screen.dart';
import 'package:firebase_test_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey =GlobalKey<FormState>();

  Future<void> _Signin() async{
    if (_formkey.currentState?.validate()??false) {
      try{
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim(),);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context)=>const HomeScreen()),
        );
      }on FirebaseAuthException catch(e) {
        String message;
        if(e.code =='user not found'){
          message = ' no user found for this email';
        }
        else if (e.code == 'wrong-password') {
          message = 'wrong password';
          
        }
        else{
          message = 'something went wrong.Please try again';
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(message)),);
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child:Padding(padding: EdgeInsets.only(bottom: 100),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

        
         Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200.0),
            image: DecorationImage(
              image: AssetImage('assets/images/pic reg.jpg'),
              fit: BoxFit.cover,)
              
            ),
     height: 200,
     width: 200,
     
        ),
        
        const SizedBox(height: 20),
        //create form
        Form(
          key: _formkey,
          child: Column(
            children: [

            
          //input email
        Container(
          
          width: 300,
        
        child:TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Enter your email',
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            
              ),
                  ),
                  validator: (value){
                    if(value==null)
                    {
                      return 'Please enter your email';
                    }
                    if (!value.contains('.')||!value.contains('@')) {
                      return 'Please enter a valid email';
                      
                    }
                    return null;
                  },
                ),
              ),
        const SizedBox(height: 20,),
        //Input Password 
        Container(
          width: 300,
          child: TextFormField(
            controller : _passwordController ,
            decoration: InputDecoration(
              labelText: 'Enter Your Password',
              prefixIcon: Icon(Icons.password),
               border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
            ),
            obscureText: true,//hides the password input by the user
            validator: (value){
               if(value==null)
                    {
                      return 'Please enter your password';
                    }
                if (value.length<8) {
                  return 'Minimum 8 characters required';
                  
                }    
                if(!RegExp(r'[A-Z]').hasMatch(value)){
                  return 'Password requires atleast one uppercase letter';
                }
                if (!RegExp(r'[a-z]').hasMatch(value)) {
                  return 'Password must contain atleast one lowercase letter';
                }
                if (!RegExp(r'[0-9]').hasMatch(value)) {
                  return 'Password must contain at least one digit';
                  
                }
                if (!RegExp('[!@#%\$^&*(),.?":{}|<>]').hasMatch(value)) {
                  return 'Password must contain at least one special character';
                }
                return null;
            },
          ),
        ),
        const SizedBox(height: 20),

        //Submit button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

          
        
         ElevatedButton(
          onPressed: _Signin,
          child: Text('Sign In',
          style: TextStyle(fontWeight: FontWeight.bold)),
          
         ),
        
        //Forgot pass button
        TextButton(
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=> ResetPasswordscreen(),
            ),
        );

          },
          child: Text('Forgot Password'),
        
                  ),
                      ],
                    ),
                    //dont have an account?sign up
                    TextButton(onPressed: (){
                      Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>SignupScreen(),
                     ),); },
                     child: Text(
                      "Don't have an account?Sign up",
                      
                     ), )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}