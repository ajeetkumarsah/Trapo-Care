import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/tabs/resources/argument.dart/resourcesArgument.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<SearchScreen> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    // var capitalizedValue =
    //     value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          // setState(() {
          //   tempSearchStore.add(queryResultSet[i]);
          // });
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['City'].toLowerCase().contains(value.toLowerCase()) ==
            true) {
          if (element['City'].toLowerCase().indexOf(value.toLowerCase()) == 0) {
            setState(() {
              tempSearchStore.add(element);
            });
          }
        }
      });
      // queryResultSet.forEach((element) {
      //   if (element['City'].startsWith(capitalizedValue)) {
      //     setState(() {
      //       tempSearchStore.add(element);
      //     });
      //   }
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: (val) {
            initiateSearch(val);
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 25.0),
            hintText: 'Search your city',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ),
      SizedBox(height: 10.0),
      ListView(
          //padding: EdgeInsets.only(left: 10.0, right: 10.0),
          primary: false,
          shrinkWrap: true,
          children: tempSearchStore.map((element) {
            String _returnDate() {
              Timestamp timestamp = element['Last Updated'];
              DateTime date = new DateTime.fromMillisecondsSinceEpoch(
                  timestamp.millisecondsSinceEpoch);
              return timeago.format(date, locale: 'fr');
            }

            return buildResultCard(element, context, _returnDate);
          }).toList())
    ]);
  }
}

Widget buildResultCard(data, context, _returnDate) {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () =>
              Navigator.of(context).pushNamed('/updatedPostViewDetails',
                  arguments: ResourcesArguments(
                    data['State'],
                    data['City'],
                    data['Address'],
                    data['Resource Type'],
                    data['Resource Subtype'],
                    data['Availability'],
                    data['Cost per Unit'],
                    data['Contact or Organization'],
                    data['Contact Number'],
                    data['Information Source'],
                    data['User Full Name'],
                    data['Last Updated'],
                  )),
          child: Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 12.0,
              bottom: 12.0,
            ),
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                  width: 1.5,
                  color: blueColor,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
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
                    child: data['Resource Type'] == 'Oxygen'
                        ? Image.asset(oxygen)
                        : data['Resource Type'] == 'Beds'
                            ? Image.asset(bed)
                            : data['Resource Type'] == 'Plasma | Blood'
                                ? Image.asset(bloodPlasma)
                                : data['Resource Type'] == 'Ambulance'
                                    ? Image.asset(ambulance)
                                    : data['Resource Type'] == 'Covid Testing'
                                        ? Image.asset(covid)
                                        : data['Resource Type'] ==
                                                'Home Care Facilities'
                                            ? Image.asset(homeCare)
                                            : data['Resource Type'] == 'Doctor'
                                                ? Image.asset(doctor)
                                                : data['Resource Type'] ==
                                                        'Hospital'
                                                    ? Image.asset(hospital)
                                                    : data['Resource Type'] ==
                                                            'Medicine'
                                                        ? Image.asset(medicine)
                                                        : Image.asset(
                                                            otherResource),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TextButton(
                      //     onPressed: () {
                      //       data.reference.updateData(
                      //           {'Status': 'Unverified'});
                      //     },
                      //     child: Text('update')),
                      Text(
                        data['Contact or Organization'] ?? 'No data',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: blueColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data['City'] ?? 'No data',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: blueColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Status : ' + _returnDate(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: blueColor,
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      data['Resource Subtype'] ?? 'Not available',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: redColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data['Contact Number'] ?? 'No data',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: blueColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('Have any Leads')
        .where('Status', isEqualTo: 'Verified')
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}
