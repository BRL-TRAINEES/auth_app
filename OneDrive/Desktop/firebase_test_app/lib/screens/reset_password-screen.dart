import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordscreen extends StatefulWidget {
  const ResetPasswordscreen({super.key});

  @override
  State<ResetPasswordscreen> createState() => _ResetPasswordscreenState();
}

class _ResetPasswordscreenState extends State<ResetPasswordscreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> _resetPassword() async {
    if (_formkey.currentState?.validate() ?? false) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset link sent. Please check your email.')),
        );
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'user-not-found') {
          message = 'No user found for this email.';
        } else {
          message = 'Something went wrong. Please try again.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
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
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _resetPassword,
                child: const Text('Reset password'),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed:(){
                  Navigator.of(context).pop(); //Navigate back

  },
               child: const Text("Back to sign in"),
  ),
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

              
 