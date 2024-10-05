import 'package:flutter/material.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey =GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child:Padding(padding: EdgeInsets.only(bottom: 80),
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
          //Input Username
          Container(
            width: 300,
           child:TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            labelText: 'Enter your Name',
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            
              ),
                  ),
                  validator: (value){
                    if(value==null)
                    {
                      return 'Please enter your Username';
                    }
                    return null;}
          ),
          ),
            const SizedBox(height: 20.0,),
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
          onPressed: (){
            if (_formkey.currentState?.validate()??false) {
               print('Username: ${_usernameController.text}');
              print('Email: ${_emailController.text}');
              print('Password: ${_passwordController.text}');
              
            }
          },
          child: Text('Sign Up',
          style: TextStyle(fontWeight: FontWeight.bold)),
          
         ),
        const SizedBox(height: 20.0),
        TextButton(onPressed: (){
          Navigator.of(context).pop();  //Navigate back to sign in screen
        },
        child: Text(
          "Already have an account?Sign in",
        ),
                    ),
                  ],
                ),
           ] ),
         ) ],
          ),
        ),
      ),
    );
  }
}
  