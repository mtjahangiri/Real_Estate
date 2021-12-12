import 'package:flutter/material.dart';
import 'package:real_estate/components/ad_image.dart';
import 'house_detail_screen.dart';
import 'package:real_estate/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'home_screen.dart';

final firestore = FirebaseFirestore.instance;

class ManageScreen extends StatefulWidget {
  static const String id = 'manage_screen';

  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  Widget buildAdListItem(BuildContext context, DocumentSnapshot document) {
    return GestureDetector(
      onTap: () {
        selectedAd = document;
        Navigator.pushNamed(context, HouseDetailScreen.id);
      },
      child: Card(
        color: Color(0xffe3e6ef),
        child: Column(
          children: [
            Row(
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
            TextButton(
              child: Text('حذف',
              style: PersianFonts.Samim.copyWith(fontSize: 18, color: Colors.red),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('از حذف آگهی خود مطمئن هستید؟'),
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
                              'حذف',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color(0xff18004d)),
                            ),
                            onPressed: () {
                              firestore.collection('Ads').doc('${document.id}').delete();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });

              },
            )
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
          backgroundColor: Color(0xff18004d),
          actions: <Widget>[],
          title: Text(
            "مدیریت آگهی ها",
            style: PersianFonts.Samim.copyWith(fontSize: 18),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: firestore
                .collection('Ads')
                .where('owner', isEqualTo: currentUser.CurrentUser.uid)
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
      ),
    );
  }
}
