import 'package:flutter/widgets.dart';

/// Creates a dotted line
class DottedLine extends StatelessWidget {
  final Color color;

  DottedLine({
    Key key,
    this.color = const Color(0xFF000000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.constrainWidth();
        final dashCount = (width / (2 * height * 0.01)).floor();
        return Flex(
          children: List.generate(
            dashCount,
            (_) => SizedBox(
              width: height * 0.01,
              height: height * 0.001,
              child: DecoratedBox(
                //position: DecorationPosition.foreground,
                decoration: BoxDecoration(color: this.color),
              ),
            ),
          ),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
