import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  final String title, image;
  const CarouselCard({Key key, this.image, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              height: 100,
              width: 120,
            ),
          ),
          SizedBox(height: 10),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 130),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Lato',
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w300,
                color: Colors.yellow[200],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
