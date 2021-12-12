import 'package:flutter/material.dart';
import 'package:real_estate/components/ad_image.dart';
import 'package:real_estate/screens/ad_manage_screen.dart';
import 'house_detail_screen.dart';
import 'addAd_screen.dart';
import 'account_manage_screen.dart';
import 'package:real_estate/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:persian_fonts/persian_fonts.dart';

//int index = 0;
DocumentSnapshot selectedAd;

final firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  String City = 'تهران', Condition = 'فروش', Type = 'آپارتمان مسکونی';

  Widget buildAdListItem(BuildContext context, DocumentSnapshot document) {
    return GestureDetector(
      onTap: () {
        selectedAd = document;
        Navigator.pushNamed(context, HouseDetailScreen.id);
      },
      child: Card(
        color: Color(0xffe3e6ef),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                    child: Text(
                      document['title'],
                      style: PersianFonts.Samim.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                    child: Text(
                      "${document['price']} تومان",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: PersianFonts.Shabnam.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                    child: Text(
                      document['date'],
                      style: PersianFonts.Shabnam.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: AdImage(
                  imagePath: "images/${document['image']}",
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: <Widget>[],
          title: Center(
              child: Text(
            "Real Estate",
            style: TextStyle(color: Color(0xff18004d)),
          )),
        ),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton(
                    value: City,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 20,
                    elevation: 16,
                    style: PersianFonts.Samim.copyWith(
                        fontSize: 18, color: Colors.black),
                    onChanged: (newValue) {
                      setState(() {
                        City = newValue;
                      });
                    },
                    items: <String>[
                      'تهران',
                      'مشهد',
                      'اصفهان',
                      'شیراز',
                      'تبریز',
                      'کرمان'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
                DropdownButton(
                    value: Condition,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 20,
                    elevation: 16,
                    style: PersianFonts.Samim.copyWith(
                        fontSize: 18, color: Colors.black),
                    onChanged: (newValue) {
                      setState(() {
                        Condition = newValue;
                      });
                    },
                    items: <String>['فروش', 'رهن', 'اجاره']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
                DropdownButton(
                    value: Type,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 20,
                    elevation: 16,
                    style: PersianFonts.Samim.copyWith(
                        fontSize: 18, color: Colors.black),
                    onChanged: (newValue) {
                      setState(() {
                        Type = newValue;
                      });
                    },
                    items: <String>[
                      'آپارتمان مسکونی',
                      'خانه ویلایی',
                      'واحد اداری',
                      'واحد تجاری',
                      'زمین و کلنگی'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
              ],
            ),
            Expanded(
              flex: 10,
              child: StreamBuilder(
                stream: firestore
                    .collection('Ads')
                    .where('type', isEqualTo: Type)
                    .where('condition', isEqualTo: Condition)
                    .where('city', isEqualTo: City)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('Loading...');
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) =>
                        buildAdListItem(context, snapshot.data.docs[index]),
                  );
                },
              ),
            ),
            Divider(
              color: Colors.indigo,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, SearchScreen.id);
                    },
                    icon: Icon(
                      Icons.search,
                      color: Color(0xff18004d),
                      size: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (currentUser.CurrentUser == null) {
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
                      } else
                        Navigator.pushNamed(context, AddAdScreen.id);
                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: Color(0xff18004d),
                      size: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (currentUser.CurrentUser == null)
                        Navigator.pushNamed(context, LoginScreen.id);
                      if(currentUser.CurrentUser != null)
                        Navigator.pushNamed(context, AccountScreen.id);
                    },
                    icon: Icon(
                      Icons.person_outline,
                      color: Color(0xff18004d),
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
