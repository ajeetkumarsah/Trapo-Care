import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/tabs/resources/argument.dart/resourcesArgument.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:trapo_care/screens/tabs/updatedPosts/widget/search_screen.dart';
import 'package:trapo_care/screens/widgets/circular_floating_buttons.dart';

class UpdatedScreen extends StatefulWidget {
  @override
  _UpdatedScreenState createState() => _UpdatedScreenState();
}

class _UpdatedScreenState extends State<UpdatedScreen>
    with TickerProviderStateMixin {
  bool _isSearch = false;
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;
  Animation rotationAnimation1;
  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 0.0, end: 135.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    rotationAnimation1 = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: _isSearch
            ? SearchScreen()
            : StreamBuilder(
                stream: Firestore.instance
                    .collection('Have any Leads')
                    .where('Status', isEqualTo: 'Verified')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView(
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
                                  top: 12.0,
                                  bottom: 12.0,
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
                                              color:
                                                  Colors.grey.withOpacity(.3),
                                              offset: Offset(0, 5),
                                              blurRadius: 35)
                                        ],
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: document['Resource Type'] ==
                                                'Oxygen'
                                            ? Image.asset(oxygen)
                                            : document['Resource Type'] ==
                                                    'Beds'
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
                                                                            ? Image.asset(medicine)
                                                                            : Image.asset(otherResource),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // TextButton(
                                          //     onPressed: () {
                                          //       document.reference.updateData(
                                          //           {'Status': 'Unverified'});
                                          //     },
                                          //     child: Text('update')),
                                          Text(
                                            document[
                                                    'Contact or Organization'] ??
                                                'No data',
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
                                    Column(
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
                                              'Not available',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: redColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          document['Contact Number'] ??
                                              'No data',
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
                    }).toList(),
                  );
                }),
        floatingActionButton: Transform(
          transform:
              Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value)),
          alignment: Alignment.center,
          child: CircularButton1(
            color: redColor,
            iconSize: _isSearch ? 35 : 50,
            width: 60,
            height: 60,
            iconColor: whiteColor,
            icon: _isSearch
                ? ImageIcon(AssetImage(
                    pluswhite,
                  ))
                : ImageIcon(
                    AssetImage(
                      search,
                    ),
                    size: 60,
                  ),
            onClick: () {
              if (animationController.isCompleted) {
                setState(() {
                  _isSearch = !_isSearch;
                });
                animationController.reverse();
              } else {
                setState(() {
                  _isSearch = !_isSearch;
                });
                animationController.forward();
              }
            },
          ),
        )

        //  CircularButton1(
        //   color: redColor,
        //   width: 60,
        //   height: 60,
        //   iconColor: whiteColor,
        // icon: _isSearch
        //     ? ImageIcon(AssetImage(
        //         pluswhite,
        //       ))
        //     : ImageIcon(AssetImage(
        //         search,
        //       )),
        //   onClick: () {
        // setState(() {
        //   _isSearch = !_isSearch;
        // });
        //   },
        // ),
        );
  }
}
