import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';
import 'package:trapo_care/screens/widgets/get_post.dart';
import 'package:trapo_care/screens/widgets/nothing_found.dart';

class Ambulance extends StatefulWidget {
  @override
  _AmbulanceState createState() => _AmbulanceState();
}

class _AmbulanceState extends State<Ambulance> {
  int defaultChoiceIndex;

  List<String> _choicesList = [
    'All',
    'Normal',
    'Advanced Life Support',
    'Mortuary Van',
  ];

  @override
  void initState() {
    super.initState();
    defaultChoiceIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
   
    return Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: 'Ambulance',
          child: kBackBtn,
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('Have any Leads')
                .where('Status', isEqualTo: 'Verified')
                .where('Resource Type', isEqualTo: 'Ambulance')
                .where('Resource Subtype',
                    isEqualTo: defaultChoiceIndex == 1
                        ? 'Normal'
                        : defaultChoiceIndex == 2
                            ? 'Advanced Life Support'
                            : defaultChoiceIndex == 3
                                ? 'Mortuary Van'
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
                          height: _height * 0.2,
                        ),
                        NothingFoundScreen(),
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
                   GetPosts(
                      snapshot: snapshot,
                    ),
                  ]),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
