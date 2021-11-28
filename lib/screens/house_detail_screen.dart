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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    elevation: 10,
                    //shadowColor: Color(0xff00076b),
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: AdImage(imagePath: "images/${selectedAd['image']}",) ),
                ),
                Expanded(
                    child: ListView(
                      children: [
                        Text(
                          selectedAd['title'],
                          style: PersianFonts.Samim.copyWith(fontWeight: FontWeight.w700,fontSize: 26 , color: Colors.black),
                        ),
                        SizedBox(height: 30,),
                        Text(
                          "قیمت: ${selectedAd['price']} تومان",
                          style: PersianFonts.Samim.copyWith(fontWeight: FontWeight.w700,fontSize: 18 , color: Colors.black),
                        ),
                        Divider(color: Colors.blueGrey),
                        Text(
                          "متراژ: ${selectedAd['area']} متر",
                          style: PersianFonts.Samim.copyWith(fontWeight: FontWeight.w700,fontSize: 18 , color: Colors.black),
                        ),
                        Divider(color: Colors.blueGrey),
                        Text(
                          "سال ساخت: ${selectedAd['year']}",
                          style: PersianFonts.Samim.copyWith(fontWeight: FontWeight.w700,fontSize: 18 , color: Colors.black),
                        ),
                        Divider(color: Colors.blueGrey),
                        Text(
                          'توضیحات:',
                          style: PersianFonts.Samim.copyWith(fontWeight: FontWeight.w700,fontSize: 18 , color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "${selectedAd['details']}",
                          style: PersianFonts.Samim.copyWith(fontWeight: FontWeight.w700,fontSize: 18 , color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    )),

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
                              title: Text('${selectedAd['phoneNo']}'),
                              titleTextStyle: TextStyle(
                                  fontSize: 17, color: Colors.black),
                              content: TextButton(
                                child: Text(
                                  'OK',
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
                    }
                    else if(loggedInUser == null){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('ابتدا وارد حساب کاربری خود شوید'),
                              titleTextStyle: TextStyle(
                                  fontSize: 17, color: Colors.black),
                              actions: [
                                TextButton(
                                  child: Text(
                                    'لغو',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Color(0xff18004d)),
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
                                        color: Color(0xff18004d)),
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
            ),
          )),
    );
  }
}