//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/components/roundedButton.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate/constants.dart';
import 'registration_screen.dart';

User loggedInUser;

class LoginScreen extends StatefulWidget {

  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final _auth = FirebaseAuth.instance;
   String email;
   String password;
   bool showSpinner = false;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        print(loggedInUser.displayName);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0A0F1C),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                  print(email);
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'ایمیل'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(style: TextStyle(color: Colors.white),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                  print(password);
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'رمز عبور'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.lightBlueAccent,
                title: 'ورود',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                   final newUser = await _auth.signInWithEmailAndPassword(
                       email: email, password: password);
                    if (newUser != null) {
                      getCurrentUser();
                      Navigator.pop(context);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    setState(() {
                      showSpinner = false;
                    });
                    String error = e.toString();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(error),
                            titleTextStyle: TextStyle(
                                fontSize: 17, color: Colors.indigo),
                            content: TextButton(
                              child: Text(
                                'OK',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.lightBlueAccent),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          );
                        });
                    print(e);
                  }
                },
              ),
              RoundedButton(
                color: Colors.blueAccent,
                title: 'ثبت نام یوزر جدید',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
              RoundedButton(
                color: Colors.blueAccent,
                title: 'خروج از حساب کاربری',
                onPressed: () {
                  _auth.signOut();
                  loggedInUser = null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
