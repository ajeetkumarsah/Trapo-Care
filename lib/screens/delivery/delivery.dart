import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/tabs/resources/argument.dart/resourcesArgument.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';

class Delivery extends StatefulWidget {
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  int defaultChoiceIndex;

  List<String> _choicesList = [
    'All',
    'Normal',
    'Home Delivery',
  ];

  @override
  void initState() {
    super.initState();
    defaultChoiceIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: 'Medicine Delivery',
          child: kBackBtn,
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('Have any Leads')
                .where('Status', isEqualTo: 'Verified')
                .where('Resource Type', isEqualTo: 'Medicine')
                .where('Resource Subtype',
                    isEqualTo: defaultChoiceIndex == 1
                        ? 'Normal'
                        : defaultChoiceIndex == 2
                            ? 'Home Delivery'
                            : null)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData || snapshot.data.documents.isEmpty) {
                return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Row(children: [
                            new Flexible(
                                child: new CustomScrollView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    slivers: <Widget>[
                                  new SliverPadding(
                                    padding: const EdgeInsets.all(6.0),
                                    sliver: new SliverList(
                                      delegate: new SliverChildListDelegate(
                                        <Widget>[
                                          Wrap(
                                              spacing: 8.0,
                                              children: List.generate(
                                                  _choicesList.length, (index) {
                                                return ChoiceChip(
                                                  labelPadding:
                                                      EdgeInsets.all(2.0),
                                                  label: Text(
                                                    _choicesList[index],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  selected:
                                                      defaultChoiceIndex ==
                                                          index,
                                                  selectedColor: redColor,
                                                  backgroundColor: blueColor
                                                      .withOpacity(0.4),

                                                  onSelected: (value) {
                                                    setState(() {
                                                      defaultChoiceIndex = value
                                                          ? index
                                                          : defaultChoiceIndex;
                                                    });
                                                  },
                                                  // backgroundColor: color,
                                                  elevation: 1,
                                                  padding: EdgeInsets.all(8.0),
                                                );
                                              }))
                                        ],
                                      ),
                                    ),
                                  ),
                                ])),
                          ]),
                        ),
                        SizedBox(
                          height: _height * 0.3,
                        ),
                        Center(
                          child: Material(
                            type: MaterialType.transparency,
                            elevation: 10.0,
                            child: Column(
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
                                ]),
                          ),
                        )
                      ],
                    ));
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Row(children: [
                        new Flexible(
                            child: new CustomScrollView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                slivers: <Widget>[
                              new SliverPadding(
                                padding: const EdgeInsets.all(6.0),
                                sliver: new SliverList(
                                  delegate: new SliverChildListDelegate(
                                    <Widget>[
                                      Wrap(
                                          spacing: 8.0,
                                          children: List.generate(
                                              _choicesList.length, (index) {
                                            return ChoiceChip(
                                              labelPadding: EdgeInsets.all(2.0),
                                              label: Text(
                                                _choicesList[index],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              selected:
                                                  defaultChoiceIndex == index,
                                              selectedColor: redColor,
                                              backgroundColor:
                                                  blueColor.withOpacity(0.4),

                                              onSelected: (value) {
                                                setState(() {
                                                  defaultChoiceIndex = value
                                                      ? index
                                                      : defaultChoiceIndex;
                                                });
                                              },
                                              // backgroundColor: color,
                                              elevation: 1,
                                              padding: EdgeInsets.all(8.0),
                                            );
                                          }))
                                    ],
                                  ),
                                ),
                              ),
                            ])),
                      ]),
                    ),
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      children: snapshot.data.documents.map((document) {
                        Timestamp timestamp = document['Last Updated'];
                        String _returnDate() {
                          DateTime date =
                              new DateTime.fromMillisecondsSinceEpoch(
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
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
                                                          ? Image.asset(
                                                              ambulance)
                                                          : document['Resource Type'] ==
                                                                  'Covid Testing'
                                                              ? Image.asset(
                                                                  covid)
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
                                                                          : document['Resource Type'] == 'Medicine'
                                                                              ? Image.asset(medicine)
                                                                              : Image.asset(otherResource),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              document[
                                                      'Contact or Organization'] ??
                                                  'Name not found',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: blueColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              document['City'] ??
                                                  'City not found',
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
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.36,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Last updated : ' +
                                                    _returnDate(),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: blueColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              Text(
                                                document['Resource Subtype'] ??
                                                    'Not found!',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: redColor,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                document['Contact Number'] ??
                                                    'Not found!',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: blueColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                    )
                  ]),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
