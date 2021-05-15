import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/posts/services/service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trapo_care/screens/widgets/circular_floating_buttons.dart';
import 'package:trapo_care/screens/widgets/emptyview.dart';
import 'helper/create_post.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';

class YourGuideScreen extends StatefulWidget {
  @override
  _YourGuideScreenState createState() => _YourGuideScreenState();
}

class _YourGuideScreenState extends State<YourGuideScreen> {
  CrudMethods crudMethods = new CrudMethods();

  Stream blogsStream;
  // ignore: unused_element
  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(40),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                new CircularProgressIndicator(),
                new Text(
                  "Please wait...",
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    //Navigator.pop(context);
    new Future.delayed(new Duration(seconds: 4), () {
      Navigator.pop(context); //pop dialog
    });
  }

  Widget blogsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('Users Post')
          .where('Status', isEqualTo: 'Verified')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return _buildList(context, snapshot.data.documents);
        } else {
          return EmptyView();
        }
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
        padding: const EdgeInsets.only(top: 20.0),
        children:
            snapshot.map((data) => _buildListItem(context, data)).toList());
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.authorName),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/fullScreenImage',
            arguments: FullScreenImageArgument(record.url)),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: whiteColor),
              borderRadius: BorderRadius.circular(5.0),
              color: whiteColor),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                        padding: EdgeInsets.all(8.0),
                        child: record.resourceType == 'Oxygen'
                            ? Image.asset(oxygen)
                            : record.resourceType == 'Beds'
                                ? Image.asset(bed)
                                : record.resourceType == 'Plasma | Blood'
                                    ? Image.asset(bloodPlasma)
                                    : record.resourceType == 'Ambulance'
                                        ? Image.asset(ambulance)
                                        : record.resourceType == 'Covid Testing'
                                            ? Image.asset(covid)
                                            : record.resourceType ==
                                                    'Home Care Facilities'
                                                ? Image.asset(homeCare)
                                                : record.resourceType ==
                                                        'Doctor'
                                                    ? Image.asset(doctor)
                                                    : record.resourceType ==
                                                            'Hospital'
                                                        ? Image.asset(hospital)
                                                        : record.resourceType ==
                                                                'Medicine'
                                                            ? Image.asset(
                                                                medicine)
                                                            : Image.asset(
                                                                otherResource),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5),
                          child: Text(
                            record.authorName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: blueColor,
                                fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5),
                          child: Text(
                            record.resourceSubtype,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: redColor,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Text(
                    record.otherDetails,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: record.url,
                    placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          enabled: true,
                          child: Container(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                color: Colors.grey,
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                              )
                              //Center(child: Text('Loading...'))
                              ),
                        )),
                //Image.network(record.url),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: blogsList(),
        floatingActionButton: CircularButton1(
          iconSize: 50,
          color: redColor,
          width: 60,
          height: 60,
          iconColor: whiteColor,
          icon: ImageIcon(AssetImage(
            postIcon,
          )),
          onClick: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateBlog()));
          },
        ));
  }
}

class BlogsTile extends StatelessWidget {
  final String imgUrl, title, description, authorName;
  BlogsTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.description,
      @required this.authorName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 170,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(authorName)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Record {
  final String authorName;
  final String otherDetails;
  final String resourceType;
  final String resourceSubtype;
  final String url;
  final String status;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['authorName'] != null),
        assert(map['imgUrl'] != null),
        assert(map['Resource Type'] != null),

        //assert(map['url'] != null),
        authorName = map['authorName'],
        otherDetails = map['Other Details'] ?? 'Not Available',
        resourceType = map['Resource Type'],
        resourceSubtype = map['Resource Subtype'] ?? 'Not Available',
        status = map['Status'] ?? 'Unverified',
        url = map['imgUrl'];
  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() =>
      "Record<$authorName:$url:$otherDetails:$resourceType:$resourceSubtype$status>";
}

class FullScreenImage extends StatelessWidget {
  final String url;

  const FullScreenImage({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: PhotoView(
        loadingBuilder: (context, event) => Center(
          child: Container(
            width: 60.0,
            height: 60.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes,
            ),
          ),
        ),
        enableRotation: true,
        imageProvider: NetworkImage(url),
      ),
    );
  }
}
