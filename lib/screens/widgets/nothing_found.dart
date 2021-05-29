// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class NewScreen extends StatelessWidget {
//   int count = 0;
//   void _addImages() {
//     var storage = FirebaseStorage.instance;
//     List<String> listOfImage = [
//       'assets/images/avatar.png',
//       'assets/images/background.png',
//       'assets/images/glap.png',
//       'assets/images/loader.png',
//       'assets/images/logo-dark.png',
//       'assets/images/logo-white.png',
//     ];
//     listOfImage.forEach((img) async {
//       String imageName = img
//           .substring(img.lastIndexOf("/"), img.lastIndexOf("."))
//           .replaceAll("/", "");

//       String path = img.substring(img.indexOf("/") + 1, img.lastIndexOf("/"));

//       final Directory systemTempDir = Directory.systemTemp;
//       final byteData = await rootBundle.load(img);
//       final file = File('${systemTempDir.path}/$imageName.jpeg');
//       await file.writeAsBytes(byteData.buffer
//           .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//       TaskSnapshot taskSnapshot =
//           await storage.ref('$path/$imageName').putFile(file);
//       final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//       await Firestore.instance
//           .collection(path)
//           .add({"url": downloadUrl, "name": imageName});
//       count++;
//       print(count);
//     });
//     print('finished.............');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addImages,
//       ),
//       appBar: AppBar(
//         title: Text('Adding images'),
//       ),
//       body: Center(
//         child: Text('Adding Images to Firebase'),
//       ),
//     );
//   }
// }