import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';

class CardView extends StatelessWidget {
  final String url, title;

  const CardView({Key key, this.url, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 70,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(url), fit: BoxFit.contain)),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
              child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: blueColor, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}

class CardView1 extends StatelessWidget {
  final String url, title;

  const CardView1({Key key, this.url, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Row(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
                child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              height: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(url), fit: BoxFit.contain)),
            )),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
