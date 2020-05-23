import 'package:flutter/material.dart';

///
class CarouselMany extends StatefulWidget {
  ///
  final List<Widget> children;

  ///
  // final int pageNumber;

  ///
  final double width, height;

  const CarouselMany({
    Key key,
    this.children,
    // this.pageNumber,
    this.width,
    this.height,
  }) : /* assert(pageNumber <= children.length),*/
        super(key: key);

  @override
  _CarouselManyState createState() => _CarouselManyState();
}

class _CarouselManyState extends State<CarouselMany> {
  int photoIndex = 0;
  DragStartDetails startHorizontalDragDetails;
  DragUpdateDetails updateHorizontalDragDetails;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children: widget.children,
      ),
    );
  }
}
