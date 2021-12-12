import 'package:flutter/material.dart';
import 'package:real_estate/components/roundedButton.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'ad_manage_screen.dart';

class AccountScreen extends StatefulWidget {
  static const String id = 'account_screen';

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 110.0,
                ),
                Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
                SizedBox(
                  height: 48.0,
                ),
                RoundedButton(
                  color: Color(0xff18004d),
                  title: 'آگهی های من',
                  onPressed: () {
                    Navigator.pushNamed(context, ManageScreen.id);
                  },
                ),
                
                RoundedButton(
                  color: Colors.grey,
                  title: 'خروج از حساب کاربری',
                  onPressed: () {
                    _auth.signOut();
                    currentUser.logout();
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('خروج از حساب با موفقیت انجام شد'),
                            titleTextStyle: TextStyle(
                                fontSize: 17, color: Colors.black),
                            content:
                              TextButton(
                                child: Text(
                                  'تایید',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color(0xff18004d)),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}