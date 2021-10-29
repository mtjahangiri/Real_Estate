import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class AdImage extends StatelessWidget {
  final String imagePath;
  AdImage({@required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getImage(context, imagePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              //width: MediaQuery.of(context).size.width/5,
              child: snapshot.data,
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Color(0xff101528),
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.width / 5,
                child: Center(child: CircularProgressIndicator()));
          }
          return Container();
        },
      ),
    );
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(image)
        .getDownloadURL();
  }
}

Future<Widget> _getImage(BuildContext context, String imageName) async {
  Image image;
  await FireStorageService.loadImage(context, imageName).then((value) {
    image = Image.network(
      value.toString(),
      fit: BoxFit.scaleDown,
    );
  });
  return image;
}
