import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';
import 'house_detail_screen.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:real_estate/components/ad_image.dart';




class SearchScreen extends StatefulWidget {
  static const String id = 'search_screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String AdTitle = '@';

  Widget buildSearchListItem(BuildContext context, DocumentSnapshot document) {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                    style: PersianFonts.Samim.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0x5f8f8f8f),
                        icon: Icon(
                          Icons.house_rounded,
                          color: Color(0xff18004d),
                          size: 40,
                        ),
                        hintText: 'جستجو',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide.none,
                        )),
                    onChanged: (value) {setState(() {
                      if(value!='') AdTitle = value.toUpperCase();
                      else AdTitle='@';
                    });
                    }),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: firestore
                      .collection('Ads').orderBy('title').startAt([AdTitle]).endAt([AdTitle +'\uf8ff'])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text('درحال بارگذاری ...');
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) => buildSearchListItem(
                          context, snapshot.data.docs[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
