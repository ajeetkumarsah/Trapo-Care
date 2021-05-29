import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';
import 'package:trapo_care/screens/widgets/get_post.dart';

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
                return GetPosts(
                  snapshot: snapshot,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
