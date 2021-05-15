import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/tabs/resources/argument.dart/resourcesArgument.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';

class Helpline extends StatefulWidget {
  @override
  _HelplineState createState() => _HelplineState();
}

class _HelplineState extends State<Helpline> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: 'Helpline & Other Resources',
          child: kBackBtn,
          fontSize: 18,
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('Have any Leads')
                .where('Status', isEqualTo: 'Verified')
                .where('Resource Type',
                    isEqualTo: 'Helpline and Other Resources')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData || snapshot.data.documents.isEmpty) {
                return Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      empty,
                      height: _height * 0.2,
                      width: _width * 0.3,
                      fit: BoxFit.fitWidth,
                    ),
                    Shimmer.fromColors(
                        baseColor: blueColor,
                        highlightColor: Colors.grey[100],
                        enabled: true,
                        child: Text('Nothing found...',
                            style: TextStyle(
                              color: blueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ))),
                  ],
                ));
              } else if (snapshot.hasData) {
                return ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  children: snapshot.data.documents.map((document) {
                    Timestamp timestamp = document['Last Updated'];
                    String _returnDate() {
                      DateTime date = new DateTime.fromMillisecondsSinceEpoch(
                          timestamp.millisecondsSinceEpoch);
                      return timeago.format(date, locale: 'fr');
                    }

                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed('/updatedPostViewDetails',
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
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 6,
                                bottom: 6,
                              ),
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                  border: Border.all(
                                    width: 1.5,
                                    color: blueColor,
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
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
                                      child: document['Resource Type'] ==
                                              'Oxygen'
                                          ? Image.asset(oxygen)
                                          : document['Resource Type'] == 'Beds'
                                              ? Image.asset(bed)
                                              : document['Resource Type'] ==
                                                      'Plasma | Blood'
                                                  ? Image.asset(bloodPlasma)
                                                  : document['Resource Type'] ==
                                                          'Ambulance'
                                                      ? Image.asset(ambulance)
                                                      : document['Resource Type'] ==
                                                              'Covid Testing'
                                                          ? Image.asset(covid)
                                                          : document['Resource Type'] ==
                                                                  'Home Care Facilities'
                                                              ? Image.asset(
                                                                  homeCare)
                                                              : document['Resource Type'] ==
                                                                      'Doctor'
                                                                  ? Image.asset(
                                                                      doctor)
                                                                  : document['Resource Type'] ==
                                                                          'Hospital'
                                                                      ? Image.asset(
                                                                          hospital)
                                                                      : document['Resource Type'] ==
                                                                              'Medicine'
                                                                          ? Image.asset(
                                                                              medicine)
                                                                          : Image.asset(
                                                                              otherResource),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          document['Contact or Organization'] ??
                                              'Name not found',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: blueColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          document['City'] ?? 'City not found',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: blueColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      width: MediaQuery.of(context).size.width *
                                          0.36,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Last updated : ' + _returnDate(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: blueColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                            document['Resource Subtype'] ??
                                                'Not found!',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: redColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            document['Contact Number'] ??
                                                'Not found!',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: blueColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
