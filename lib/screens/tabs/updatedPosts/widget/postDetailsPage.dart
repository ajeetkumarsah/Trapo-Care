import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/controller/styles.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatedPostViewDetails extends StatelessWidget {
  final String state,
      city,
      address,
      resourceType,
      resourceSubtype,
      otherDetails,
      costperUnit,
      contactPerson,
      contactNumber,
      informationSource,
      userFullName;
  final Timestamp date;

  const UpdatedPostViewDetails(
      {Key key,
      this.state,
      this.city,
      this.address,
      this.resourceType,
      this.resourceSubtype,
      this.otherDetails,
      this.costperUnit,
      this.contactPerson,
      this.contactNumber,
      this.informationSource,
      this.userFullName,
      this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () => Navigator.pop(context),
        title: 'Leads Details',
        child: kBackBtn,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 1.2,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Card(
                  color: Styles.commonDarkCardBackground,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Text(contactPerson ?? 'Not Available',
                            style: Styles.title.copyWith(
                              color: blueColor,
                              height: 1,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            )),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(70.0, 10, 70.0, 10.0),
                          child: Divider(
                            color: Colors.grey[500],
                            height: 4,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            address != null
                                ? '$address ,  $city,  $state'
                                : '$city, $state ',
                            textAlign: TextAlign.center,
                            //overflow: TextOverflow.ellipsis,
                            style: Styles.p,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.usps,
                    color: blueColor,
                  ),
                  title: Text(
                    'Posted by',
                  ),
                  subtitle: Text(
                    userFullName ?? 'Not Available',
                  ),
                ),
                Divider(
                  height: 20.0,
                ),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.sourcetree,
                    color: blueColor,
                  ),
                  title: Text('Resource Type'),
                  subtitle: Text(resourceType ?? 'Not Available'),
                ),
                Divider(
                  height: 20.0,
                ),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.userAlt,
                    color: blueColor,
                  ),
                  title: Text('Resource Sub Type'),
                  subtitle: Text(resourceSubtype ?? 'Not Available'),
                ),
                Divider(
                  height: 20.0,
                ),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.rupeeSign,
                    color: blueColor,
                  ),
                  title: Text('Cost per Unit'),
                  subtitle: Text(costperUnit ?? 'Not Available'),
                ),
                Divider(
                  height: 40.0,
                ),
                new Center(
                  // ignore: deprecated_member_use
                  child: new FlatButton(
                      color: blueColor,
                      onPressed: () => launch(('tel://$contactNumber')),
                      child: new Text(
                        "Call Now",
                        style: TextStyle(color: whiteColor),
                      )),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
