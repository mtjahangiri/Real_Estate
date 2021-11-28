import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';
import 'screens/addAd_screen.dart';
import 'package:real_estate/screens/house_detail_screen.dart';
import 'package:real_estate/screens/login_Screen.dart';
import 'screens/registration_screen.dart';
import 'screens/ad_manage_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RealEstate());
}

class RealEstate extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fa', ''),
      ],
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong!');
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      //initialRoute: HomeScreen.id,
      routes: {
        HouseDetailScreen.id: (context) => HouseDetailScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        AddAdScreen.id: (context) => AddAdScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ManageScreen.id: (context) => ManageScreen(),
      },
    );
  }
}
