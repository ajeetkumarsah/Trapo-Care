import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget child;
  final double fontSize;
  final Function onPressed;
  final Function onTitleTapped;

  @override
  final Size preferredSize;
  CustomAppBar(
      {@required this.title,
      @required this.child,
      @required this.onPressed,
      this.onTitleTapped,
      this.fontSize})
      : preferredSize = Size.fromHeight(60.0);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: whiteColor, //blueColor.withOpacity(0.95),
        child: Column(
          children: <Widget>[
            // SizedBox(height: 30,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Hero(
                  tag: 'topBarBtn',
                  child: Card(
                    color: blueColor,
                    elevation: 10,
                    shape: kBackButtonShape,
                    child: MaterialButton(
                      height: 50,
                      minWidth: 50,
                      elevation: 10,
                      shape: kBackButtonShape,
                      onPressed: onPressed,
                      child: child,
                    ),
                  ),
                ),
                Hero(
                  tag: 'title',
                  transitionOnUserGestures: true,
                  child: Card(
                    color: blueColor,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    child: InkWell(
                      onTap: onTitleTapped,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 50,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              title,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: fontSize != null ? fontSize : 23,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

ShapeBorder kBackButtonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30),
  ),
);

Widget kBackBtn = Icon(
  Icons.arrow_back_ios,
  color: whiteColor,
);
