import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/controller/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'custom_appbar.dart';

class PostViewDetails extends StatelessWidget {
  final String username,
      hospitalName,
      hContact,
      otherInfo,
      hAddress,
      resourcestype,
      verifiedBy,
      pricePerDay;

  const PostViewDetails(
      {Key key,
      this.username,
      this.hospitalName,
      this.hContact,
      this.otherInfo,
      this.hAddress,
      this.resourcestype,
      this.verifiedBy,
      this.pricePerDay})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: 'Details',
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
                            Text(hospitalName,
                                style: Styles.title.copyWith(
                                  color: blueColor,
                                  height: 1,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  70.0, 10, 70.0, 10.0),
                              child: Divider(
                                color: Colors.grey[500],
                                height: 4,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                hAddress ?? 'Not Available',
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
                        username ?? 'Not Available',
                      ),
                    ),
                    Container(
                      height: 10.0,
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.hospitalUser,
                        color: blueColor,
                      ),
                      title: Text(
                        'Contact Number',
                      ),
                      subtitle: Text(hContact ?? 'Not Available'),
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
                      subtitle: Text(resourcestype ?? 'Not Available'),
                    ),
                    Divider(
                      height: 20.0,
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.userAlt,
                        color: blueColor,
                      ),
                      title: Text('Verified By'),
                      subtitle: Text(verifiedBy ?? 'Not Available'),
                    ),
                    pricePerDay != null
                        ? Divider(
                            height: 20.0,
                          )
                        : SizedBox(),
                    pricePerDay == null
                        ? Container()
                        : ListTile(
                            leading: Icon(
                              FontAwesomeIcons.rupeeSign,
                              color: blueColor,
                            ),
                            title: Text('Price per day'),
                            subtitle: Text(pricePerDay ?? 'Not Available'),
                          ),
                    Divider(
                      height: 20.0,
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.infoCircle,
                        color: blueColor,
                      ),
                      title: Text('Other Infomation'),
                      subtitle: Text(otherInfo ?? 'Not Available'),
                    ),
                    Divider(
                      height: 40.0,
                    ),
                    new Center(
                      // ignore: deprecated_member_use
                      child: new FlatButton(
                          color: blueColor,
                          onPressed: () => launch(('tel://$hContact')),
                          child: new Text(
                            "Call Now",
                            style: TextStyle(color: whiteColor),
                          )),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
