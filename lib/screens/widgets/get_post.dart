import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/tabs/resources/argument.dart/resourcesArgument.dart';
import 'package:timeago/timeago.dart' as timeago;

class GetPosts extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;

  const GetPosts({Key key, @required this.snapshot}) : super(key: key);

  @override
  _GetPostsState createState() => _GetPostsState();
}

class _GetPostsState extends State<GetPosts> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      children: widget.snapshot.data.documents.map((document) {
        Timestamp timestamp = document['Last Updated'];
        String _returnDate() {
          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              timestamp.millisecondsSinceEpoch);
          return timeago.format(date, locale: 'fr');
        }

        String resource = document['Resource Type'];
        String subresource = document['Resource Subtype'];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  width: 1.5,
                  color: blueColor,
                )),
            child: GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed('/updatedPostViewDetails',
                      arguments: ResourcesArguments(
                        document['State'],
                        document['City'],
                        document['Address'],
                        document['Resource Type'],
                        document['Resource Subtype'],
                        document['Other Details'],
                        document['Cost per Unit'],
                        document['Contact or Organization'],
                        document['Contact Number'],
                        document['Information Source'],
                        document['User Full Name'],
                        document['Last Updated'],
                      )),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          offset: Offset(0, 5),
                          blurRadius: 35)
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: document['Resource Type'] == 'Oxygen'
                        ? Image.asset(oxygen)
                        : document['Resource Type'] == 'Beds'
                            ? Image.asset(bed)
                            : document['Resource Type'] == 'Plasma | Blood'
                                ? Image.asset(bloodPlasma)
                                : document['Resource Type'] == 'Ambulance'
                                    ? Image.asset(ambulance)
                                    : document['Resource Type'] ==
                                            'Covid Testing'
                                        ? Image.asset(covid)
                                        : document['Resource Type'] ==
                                                'Home Care Facilities'
                                            ? Image.asset(homeCare)
                                            : document['Resource Type'] ==
                                                    'Doctor'
                                                ? Image.asset(doctor)
                                                : document['Resource Type'] ==
                                                        'Hospital'
                                                    ? Image.asset(hospital)
                                                    : document['Resource Type'] ==
                                                            'Medicine'
                                                        ? Image.asset(medicine)
                                                        : document['Resource Type'] ==
                                                                'Food'
                                                            ? Image.asset(food)
                                                            : Image.asset(
                                                                otherResource),
                  ),
                ),
                title: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document['Contact or Organization'] ?? 'No data',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: blueColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        document['City'] ?? 'No data',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: blueColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                trailing: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _returnDate(),
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: blueColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        subresource == null ? resource : subresource,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: redColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        document['Contact Number'] ?? 'No data',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: blueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        //  Column(
        //   children: <Widget>[
        //     Padding(
        //       padding: EdgeInsets.all(10),
        //       child: GestureDetector(
        //         onTap: () =>
        //             Navigator.of(context).pushNamed('/updatedPostViewDetails',
        //                 arguments: ResourcesArguments(
        //                   document['State'],
        //                   document['City'],
        //                   document['Address'],
        //                   document['Resource Type'],
        //                   document['Resource Subtype'],
        //                   document['Other Details'],
        //                   document['Cost per Unit'],
        //                   document['Contact or Organization'],
        //                   document['Contact Number'],
        //                   document['Information Source'],
        //                   document['User Full Name'],
        //                   document['Last Updated'],
        //                 )),
        //         child: Container(
        //           padding: EdgeInsets.only(
        //             left: 10,
        //             right: 10,
        //             top: 6,
        //             bottom: 6,
        //           ),
        //           height: 100,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.all(Radius.circular(4.0)),
        //               border: Border.all(
        //                 width: 1.5,
        //                 color: blueColor,
        //               )),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Container(
        //                 width: 60,
        //                 height: 60,
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //                   border: Border.all(
        //                     color: Colors.white,
        //                     width: 2,
        //                   ),
        //                   boxShadow: [
        //                     BoxShadow(
        //                         color: Colors.grey.withOpacity(.3),
        //                         offset: Offset(0, 5),
        //                         blurRadius: 35)
        //                   ],
        //                 ),
        //                 child: Container(
        //                   padding: EdgeInsets.all(10),
        //                   child: document['Resource Type'] == 'Oxygen'
        //                       ? Image.asset(oxygen)
        //                       : document['Resource Type'] == 'Beds'
        //                           ? Image.asset(bed)
        //                           : document['Resource Type'] ==
        //                                   'Plasma | Blood'
        //                               ? Image.asset(bloodPlasma)
        //                               : document['Resource Type'] == 'Ambulance'
        //                                   ? Image.asset(ambulance)
        //                                   : document['Resource Type'] ==
        //                                           'Covid Testing'
        //                                       ? Image.asset(covid)
        //                                       : document['Resource Type'] ==
        //                                               'Home Care Facilities'
        //                                           ? Image.asset(homeCare)
        //                                           : document['Resource Type'] ==
        //                                                   'Doctor'
        //                                               ? Image.asset(doctor)
        //                                               : document['Resource Type'] ==
        //                                                       'Hospital'
        //                                                   ? Image.asset(
        //                                                       hospital)
        //                                                   : document['Resource Type'] ==
        //                                                           'Medicine'
        //                                                       ? Image.asset(
        //                                                           medicine)
        //                                                       : Image.asset(
        //                                                           otherResource),
        //                 ),
        //               ),
        //               SizedBox(
        //                 width: 10,
        //               ),
        //               Container(
        //                 width: MediaQuery.of(context).size.width * 0.3,
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text(
        //                       document['Contact or Organization'] ??
        //                           'Name not found',
        //                       overflow: TextOverflow.ellipsis,
        //                       style: TextStyle(
        //                           color: blueColor,
        //                           fontSize: 20,
        //                           fontWeight: FontWeight.bold),
        //                     ),
        //                     Text(
        //                       document['City'] ?? 'City not found',
        //                       overflow: TextOverflow.ellipsis,
        //                       style: TextStyle(
        //                           color: blueColor,
        //                           fontSize: 15,
        //                           fontWeight: FontWeight.bold),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               Container(
        //                   padding: EdgeInsets.only(top: 10, bottom: 10),
        //                   width: MediaQuery.of(context).size.width * 0.36,
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     crossAxisAlignment: CrossAxisAlignment.end,
        //                     children: [
        //                       Text(
        //                         'Last updated : ' + _returnDate(),
        //                         overflow: TextOverflow.ellipsis,
        //                         style: TextStyle(
        //                             color: blueColor,
        //                             fontSize: 12,
        //                             fontWeight: FontWeight.normal),
        //                       ),
        //                       Text(
        //                         subresource != null ? subresource : resource,
        //                         overflow: TextOverflow.ellipsis,
        //                         style: TextStyle(
        //                             color: redColor,
        //                             fontSize: 13,
        //                             fontWeight: FontWeight.bold),
        //                       ),
        //                       Text(
        //                         document['Contact Number'] ?? 'Not found!',
        //                         overflow: TextOverflow.ellipsis,
        //                         style: TextStyle(
        //                             color: blueColor,
        //                             fontSize: 16,
        //                             fontWeight: FontWeight.bold),
        //                       ),
        //                     ],
        //                   )),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // );
      }).toList(),
    );
  }
}
