import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:url_launcher/url_launcher.dart';

class SliderWidget extends StatelessWidget {
  _launchURL() async {
    const url =
        'https://milaap.org/fundraisers/support-trapo-care?utm_source=whatsapp&utm_medium=fundraisers-title&mlp_referrer_id=4999411';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CarouselSlider(
          items: [
            //1st Image of Slider
            GestureDetector(
                onTap: () => _launchURL(),
                child: Container(
                  alignment: Alignment.bottomRight,
                  width: MediaQuery.of(context).size.width,
                  //alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(top: 6, bottom: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(banner1),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    height: 50,
                    width: 204,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: AssetImage(donateLabel),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )),

            GestureDetector(
                onTap: () => _launchURL(),
                child: Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(top: 6, bottom: 6),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(banner2),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    height: 50,
                    width: 204,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: AssetImage(donateLabel),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )),
          ],

          //Slider Container properties
          options: CarouselOptions(
            height: 200.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.98,
          ),
        ),
      ],
    );
  }
}
