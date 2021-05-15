// import 'package:flutter/material.dart';
// import 'package:trapo_care/controller/color.dart';

// class ListViewWidget extends StatelessWidget {
//   // final String title, location;
//   // final Icon leading, trailing;

//   // const ListViewWidget(
//   //     {Key key, this.title, this.location, this.leading, this.trailing})
//   //     : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       scrollDirection: Axis.vertical,
//       shrinkWrap: true,
//       itemCount: 10,
//       itemBuilder: (BuildContext context, int index) {
//         return Card(
//           elevation: 8.0,
//           margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
//           child: Container(
//             decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, .155)),
//             child: ListTile(
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//                 leading: Container(
//                   padding: EdgeInsets.only(right: 12.0),
//                   decoration: new BoxDecoration(
//                       border: new Border(
//                           right: new BorderSide(
//                               width: 1.0, color: Colors.white24))),
//                   child: Icon(Icons.vignette_outlined, color: Colors.grey),
//                 ),
//                 title: Text(
//                   "Oxygen on Rent",
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),
//                 // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

//                 subtitle: Row(
//                   children: <Widget>[
//                     Icon(
//                       Icons.location_on,
//                       color: greenColor,
//                       size: 16,
//                     ),
//                     Text(" Kolkata", style: TextStyle(color: Colors.black))
//                   ],
//                 ),
//                 trailing: Icon(Icons.keyboard_arrow_right,
//                     color: Colors.grey, size: 30.0)),
//           ),
//         );
//       },
//     );
//   }
// }
