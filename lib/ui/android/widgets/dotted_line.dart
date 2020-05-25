import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Creates a dotted line
class DottedLine extends StatelessWidget {
  final BoxDecoration decoration;
  final double height, dotWidth, space;
  final Axis direction;

  DottedLine({
    Key key,
    this.height,
    @required this.direction,
    @required this.dotWidth,
    this.decoration,
    this.space = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final width = constraints.constrainWidth();
        final dashCount = (width / (dotWidth * space)).floor();
        return Flex(
          children: List.generate(
            dashCount,
            (_) => SizedBox(
              width: dotWidth,
              height: height ?? 2,
              child: DecoratedBox(
                decoration: decoration ??
                    const BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
              ),
            ),
          ),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: direction ?? Axis.horizontal,
        );
      },
    );
  }
}
