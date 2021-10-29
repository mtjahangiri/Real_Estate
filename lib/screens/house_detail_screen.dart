import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/components/ad_image.dart';
import 'package:real_estate/components/roundedButton.dart';
import 'home_screen.dart';
import 'login_Screen.dart';
import 'package:persian_fonts/persian_fonts.dart';

class HouseDetailScreen extends StatelessWidget {
  static const String id = 'house_detail_screen';

  // final String houseaddress;
  // final String sellmanphone_number;
  // final String houseDescription;
  // final Image houseprice;
  // final int n = index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xef212547),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: ListView(
                    children: [],
                  )),
              Expanded(
                flex: 7,
                child: Card(
                  elevation: 20,
                  shadowColor: Color(0xff00076b),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: AdImage(imagePath: "images/${selectedAd['image']}.jpg",) ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  selectedAd['title'],
                  style: PersianFonts.Samim.copyWith(fontWeight: FontWeight.w700,fontSize: 26 , color: Colors.white),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "${selectedAd['price']} تومان",
                  style: PersianFonts.Samim.copyWith(fontWeight: FontWeight.w700,fontSize: 18 , color: Colors.white),
                ),
              ),
              Expanded(
                child: Text(
                  'توضیحات:',
                  style: PersianFonts.Samim.copyWith(fontWeight: FontWeight.w700,fontSize: 18 , color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.vertical,
                  child: Text(
                    "${selectedAd['description']}",
                     style: PersianFonts.Samim.copyWith(fontWeight: FontWeight.w700,fontSize: 18 , color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              RoundedButton(
                color: Colors.lightBlue,
                onPressed: () async {
                  if (loggedInUser != null) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('${loggedInUser.photoURL}'),
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
                  }
                  else if(loggedInUser == null){
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('ابتدا وارد حساب خود شوید'),
                            titleTextStyle: TextStyle(
                                fontSize: 17, color: Colors.indigo),
                            actions: [
                              TextButton(
                                child: Text(
                                  'لغو',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.lightBlueAccent),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'ورود به حساب',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.lightBlueAccent),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, LoginScreen.id);
                                },
                              ),
                            ],
                          );
                        });
                  }
                },
                title: 'تماس',
              ),
            ],
          )),
    );
  }
}