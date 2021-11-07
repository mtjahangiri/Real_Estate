import 'package:real_estate/constants.dart';
import 'login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/components/roundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String name;
  String phoneNo;
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
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                  print(name);
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'نام'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  phoneNo = value;
                  print(phoneNo);
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'موبایل'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                  print(email);
                },
                decoration:
                kTextFieldDecoration.copyWith(hintText: 'ایمیل'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                  print(password);
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'رمز عبور'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.blueAccent,
                title: 'ثبت نام',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      newUser.user.updateDisplayName(name);
                      newUser.user.updatePhotoURL(phoneNo);
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
            ],
          ),
        ),
      ),
    );
  }
}
