import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/helper/imageHelper.dart';

class SliderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CarouselSlider(
          items: [
            //1st Image of Slider
            GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/donateScreen'),
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
                onTap: () => Navigator.of(context).pushNamed('/donateScreen'),
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
