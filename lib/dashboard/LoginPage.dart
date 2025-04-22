import 'package:daily_task_app/app/theme.dart';
import 'package:daily_task_app/auth/auth_service.dart';
import 'package:daily_task_app/dashboard/RegisterPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginpageState();
}

class _LoginpageState extends State<LoginPage> {
  // get auth servic
  final authServic = AuthService();

  //text controller
  final _emailControler = TextEditingController();
  final _passwordController = TextEditingController();


  void login() async {
    final email = _emailControler.text;
    final password = _passwordController.text;

    // attempt login
    try {
      await authServic.signInWithEmailPassword(email, password);
    }
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error:$e')));
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
        }, icon:appColor().iconChange),
      ),
      backgroundColor: appColor().Background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('LOGIN',
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
            Container(
              width: 300,
              child: ElevatedButton(onPressed: () {login();},
                child: Text('Log In',
                  style: TextStyle(color: appColor().Primary, fontSize: 20),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: appColor().Secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),),
            ),
            SizedBox(height: 10,),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute ( builder: (BuildContext context) => RegisterPage() ));
                },
                child: Text("Don't have an account? Sign up",
                  style: TextStyle(fontSize: 17,
                      color: appColor().Primary),)),
          ],
        ),
      ),
    );
  }
}
