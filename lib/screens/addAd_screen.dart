import 'dart:io';
import 'package:flutter/material.dart';
import 'package:real_estate/components/roundedButton.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:real_estate/constants.dart';
import 'package:real_estate/screens/home_screen.dart';
import 'package:real_estate/screens/login_Screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shamsi_date/shamsi_date.dart';

class AddAdScreen extends StatefulWidget {
  static const String id = 'ad_screen';

  @override
  _AddAdScreenState createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {

  bool showSpinner = false;
  File _image;
  String _uploadedFileURL;

  String title = '',
      area = '',
      price = '',
      year = '',
      details = '',
      city = 'تهران',
      condition = 'فروش',
  type = 'آپارتمان مسکونی';

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 100).then((image) {
      setState(() {
        _image = image;
      });
    });
    uploadFile();
  }

  Future uploadFile() async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(_image.path)}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        print(fileURL);
      });
    });
  }

  String format(Date d) {
    final f = d.formatter;
    return '${f.yyyy}/${f.mm}/${f.dd}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'افزودن آگهی',
            style: PersianFonts.Samim.copyWith(fontSize: 18, color: Colors.black),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if(_uploadedFileURL != null)
                  Card(child: Image.network(_uploadedFileURL, height: 200,))
                else Container(),
                _image == null
                    ? RoundedButton(
                  title: 'انتخاب عکس',
                  onPressed: (){chooseFile();},
                  color: Colors.cyan,
                )
                    : Container(),
                _image != null
                    ? RoundedButton(
                        title:'پاک کردن عکس',
                        color: Colors.cyan,
                        onPressed: () {setState(() {
                          _image= null;
                          _uploadedFileURL='https://firebasestorage.googleapis.com/v0/b/real-estate-554a4.appspot.com/o/images%2Fno-image-1771002-1505134.png?alt=media&token=95317d9a-f750-4235-9696-3cdc1b5c3043';
                        });},
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton(
                        value: city,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 20,
                        elevation: 16,
                        style: PersianFonts.Samim.copyWith(
                            fontSize: 18, color: Colors.black),
                        onChanged: (newValue) {
                          setState(() {
                            city = newValue;
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
                        value: condition,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 20,
                        elevation: 16,
                        style: PersianFonts.Samim.copyWith(
                            fontSize: 18, color: Colors.black),
                        onChanged: (newValue) {
                          setState(() {
                            condition = newValue;
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
                        value: type,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 20,
                        elevation: 16,
                        style: PersianFonts.Samim.copyWith(
                            fontSize: 18, color: Colors.black),
                        onChanged: (newValue) {
                          setState(() {
                            type = newValue;
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
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  '   عنوان آگهی',
                  style: PersianFonts.Samim.copyWith(
                      fontSize: 18, color: Colors.black),
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  onChanged: (value) {title = value;},
                  decoration: kTextFieldDecoration,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  '   متراژ',
                  style: PersianFonts.Samim.copyWith(
                      fontSize: 18, color: Colors.black),
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  maxLength: 7,
                  textAlign: TextAlign.center,
                  onChanged: (value) {area = value;},
                  decoration: kTextFieldDecoration,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  '   قیمت کل(تومان)',
                  style: PersianFonts.Samim.copyWith(
                      fontSize: 18, color: Colors.black),
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {price = value;},
                  decoration: kTextFieldDecoration,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  '   سال ساخت',
                  style: PersianFonts.Samim.copyWith(
                      fontSize: 18, color: Colors.black),
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (value) {year = value;},
                  decoration: kTextFieldDecoration,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  '   توضیحات',
                  style: PersianFonts.Samim.copyWith(
                      fontSize: 18, color: Colors.black),
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  maxLines: 20,
                  textAlign: TextAlign.start,
                  onChanged: (value) {details = value;},
                  decoration: kTextFieldDecoration,
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  color: Colors.cyan,
                  title: 'افزودن',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      firestore.collection(type).add({
                        'title': title,
                        'condition': condition,
                        'city': city,
                        'area': area,
                        'price': price,
                        'year': year,
                        'details': details,
                        'image': '${Path.basename(_image.path)}',
                        'phoneNo': loggedInUser.photoURL,
                        'seller': loggedInUser.displayName,
                        'date': format(Jalali.now()),
                        'date1': DateTime.now(),
                      });
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.pop(context);
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
                              titleTextStyle:
                                  TextStyle(fontSize: 17, color: Colors.indigo),
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
      ),
    );
  }
}
