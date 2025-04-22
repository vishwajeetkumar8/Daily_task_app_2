import 'package:daily_task_app/dashboard/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app/theme.dart';
import '../auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<RegisterPage> {

  // get auth servic
  final authServic = AuthService();

  //text controller
  final _emailControler = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassword = TextEditingController();

  // sing up button pressed
  void signUp()async {
    final email = _emailControler.text;
    final password = _passwordController.text;
    final confirmpassword = _confirmPassword.text;
    
    // check the password
    if (password != confirmpassword){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password don't match")));
      return;
    }
    try{
      await authServic.signUpWithEmailPassword(email, password);
      Navigator.pop(context);
    }
    catch(e){
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));

        }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor().Background,
        leading: IconButton(onPressed: () {
          setState(() {
            appColor().changeMode();
          });
        },icon:appColor().iconChange),
      ),
      backgroundColor: appColor().Background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('NEW ACCOUNT',
              style: TextStyle(color: appColor().TextPrimary, fontSize: 40),),
            SizedBox(height: 40,),
            Container(width: 300,
              child: TextField(
                controller: _emailControler,
                style: TextStyle(color: appColor().TextPrimary),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  label: Text('Email Address'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),

              ),
            ),
            SizedBox(height: 20,),
            Container(width: 300,
              child: TextField(
                controller: _passwordController,
                style: TextStyle(color: appColor().TextPrimary),
                decoration: InputDecoration(
                  label: Text('Password'),
                  prefixIcon: Icon(Icons.lock),
                  fillColor: appColor().Primary,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),

              ),
            ),
            SizedBox(height: 20,),
            Container(width: 300,
              child: TextField(
                controller: _confirmPassword,
                style: TextStyle(color: appColor().TextPrimary),
                decoration: InputDecoration(
                  label: Text('Conform Password'),
                  prefixIcon: Icon(Icons.lock),
                  fillColor: appColor().Primary,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),

              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: 300,
              child: ElevatedButton(onPressed: () {signUp();},
                child: Text('Sign Up',
                  style: TextStyle(color: appColor().Primary, fontSize: 20),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: appColor().Secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),),
            ),
            SizedBox(height: 10,),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute ( builder: (BuildContext context) => LoginPage() ));
                },
                child: Text("Already have account? ",
                  style: TextStyle(fontSize: 17,
                      color: appColor().Primary),)),
          ],
        ),
      ),
    );
  }
}
