import 'package:flutter/material.dart';
import 'package:real_estate/components/ad_image.dart';
import 'house_detail_screen.dart';
import 'package:real_estate/screens/login_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:intl/intl.dart';

int index = 0;
DocumentSnapshot selectedAd;

final firestore = FirebaseFirestore.instance;
String order = '';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  Widget buildAdListItem(BuildContext context, DocumentSnapshot document) {
    return GestureDetector(
      onTap: (){
        selectedAd=document;
        Navigator.pushNamed(
            context,
            HouseDetailScreen.id);
      },
      child: Card(
        color: Color(0xff383556),
        child: Row(
          children: [
            Expanded(
              flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric (vertical: 5.0 ,horizontal: 15),
                      child: Text(
                        document['title'],
                        style: PersianFonts.Samim.copyWith(fontWeight: FontWeight.w700,fontSize: 18 , color: Colors.white),
                      ),
                    ),
                    SizedBox( height: 25, ),
                    Padding(
                      padding: EdgeInsets.symmetric (vertical: 5.0 ,horizontal: 20),
                      child: Text(
                        "${document['price'].toString()} تومان",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: PersianFonts.Shabnam.copyWith(fontWeight: FontWeight.w700 , color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric (vertical: 5.0 ,horizontal: 20),
                      child: Text(
                        document['date'].toString(),
                        style: PersianFonts.Shabnam.copyWith(fontWeight: FontWeight.w700 , color: Colors.white),
                      ),
                    ),
                  ],
                ),
            ),
            Expanded(
                flex: 1,
                child: AdImage(imagePath: "images/${document['image']}.jpg",)),
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
          backgroundColor: Color(0xff0A0F1C),
          actions: <Widget>[],
          title: Center(child: Text("Real Estate")),
        ),
        backgroundColor: Color(0xff181526),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: StreamBuilder(
                stream: firestore
                    .collection('Ads')
                    .orderBy('date', descending: true)
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
              color: Colors.black,
              thickness: 1,
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.home_filled,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, SearchScreen.id);
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.blueGrey,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    // onPressed: () {
                    //   if(loggedInUser == null){
                    //     showDialog(
                    //         context: context,
                    //         builder: (context) {
                    //           return AlertDialog(
                    //             title: Text('You Should login first'),
                    //             titleTextStyle: TextStyle(
                    //                 fontSize: 17, color: Colors.indigo),
                    //             actions: [
                    //               TextButton(
                    //                 child: Text(
                    //                   'Cancel',
                    //                   style: TextStyle(
                    //                       fontSize: 17,
                    //                       color: Colors.lightBlueAccent),
                    //                 ),
                    //                 onPressed: () {
                    //                   Navigator.pop(context);
                    //                 },
                    //               ),
                    //               TextButton(
                    //                 child: Text(
                    //                   'Log in',
                    //                   style: TextStyle(
                    //                       fontSize: 17,
                    //                       color: Colors.lightBlueAccent),
                    //                 ),
                    //                 onPressed: () {
                    //                   Navigator.pop(context);
                    //                   Navigator.pushNamed(
                    //                       context, LoginScreen.id);
                    //                 },
                    //               ),
                    //             ],
                    //           );
                    //         });
                    //   }
                    //   else Navigator.pushNamed(context, OrdersScreen.id);
                    // },
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.blueGrey,
                      size: 35,
                    ),
                  ),
                  // IconButton(
                    // onPressed: () {
                    //   if(loggedInUser == null){
                    //     showDialog(
                    //         context: context,
                    //         builder: (context) {
                    //           return AlertDialog(
                    //             title: Text('You Should login first'),
                    //             titleTextStyle: TextStyle(
                    //                 fontSize: 17, color: Colors.indigo),
                    //             actions: [
                    //               TextButton(
                    //                 child: Text(
                    //                   'Cancel',
                    //                   style: TextStyle(
                    //                       fontSize: 17,
                    //                       color: Colors.lightBlueAccent),
                    //                 ),
                    //                 onPressed: () {
                    //                   Navigator.pop(context);
                    //                 },
                    //               ),
                    //               TextButton(
                    //                 child: Text(
                    //                   'Log in',
                    //                   style: TextStyle(
                    //                       fontSize: 17,
                    //                       color: Colors.lightBlueAccent),
                    //                 ),
                    //                 onPressed: () {
                    //                   Navigator.pop(context);
                    //                   Navigator.pushNamed(
                    //                       context, LoginScreen.id);
                    //                 },
                    //               ),
                    //             ],
                    //           );
                    //         });
                    //   }
                    //   else Navigator.pushNamed(context, MyBooksScreen.id);
                    // },
                    // icon: Icon(
                    //   Icons.shopping_cart,
                    //   color: Colors.blueGrey,
                    //   size: 35,
                    // ),
                  // ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.blueGrey,
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
