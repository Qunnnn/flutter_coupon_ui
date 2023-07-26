import 'package:flutter/material.dart';

class CouponWidget extends StatelessWidget {
  final double borderRadius;
  final double clipRadius;
  final double defaultPadding;
  const CouponWidget(
      {super.key,
      this.borderRadius = 10,
      this.clipRadius = 10,
      this.defaultPadding = 25});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final couponWidth = screenSize.width;
    final couponHeight = screenSize.height;
    return SizedBox(
      height: couponHeight * 0.15,
      width: couponWidth,
      child: Stack(children: [
        ClipPath(
          clipper:
              CustomCoupon(borderRadius: borderRadius, clipRadius: clipRadius),
          child: Container(
            color: Colors.white,
          ),
        ),
        Positioned(
          top: defaultPadding,
          bottom: defaultPadding,
          left: couponWidth * 0.3,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: List.generate(
                    (constraints.constrainHeight() / 10).floor(),
                    (index) => Container(
                          height: 5,
                          width: 1,
                          color: Colors.red,
                        )),
              );
            },
          ),
        ),
        Positioned(
            top: 10,
            left: defaultPadding,
            right: defaultPadding,
            bottom: 10,
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 70,
                    color: Colors.red,
                  ),
                  Container(
                    height: 100,
                    width: 210,
                    color: Colors.red,
                  ),
                ],
              ),
            ))
      ]),
    );
  }
}

class CustomCoupon extends CustomClipper<Path> {
  final double borderRadius;
  final double clipRadius;
  const CustomCoupon({required this.borderRadius, required this.clipRadius});
  @override
  getClip(Size size) {
    final clipCenterX = size.width * 0.3;
    final frameCoupon = Path();
    // frameCoupon.addRRect(RRect.fromRectAndRadius(
    //   Rect.fromLTWH(0, 0, size.width, size.height),
    //   Radius.circular(borderRadius),
    // ));

    frameCoupon.addRRect(RRect.fromLTRBR(
      15,
      size.height,
      size.width - 15,
      0,
      Radius.circular(borderRadius),
    ));
    final clipPath = Path();
    // circle on the top
    clipPath.addOval(Rect.fromCircle(
      center: Offset(clipCenterX, 0),
      radius: clipRadius,
    ));
    // circle on the bottom
    clipPath.addOval(Rect.fromCircle(
      center: Offset(clipCenterX, size.height),
      radius: clipRadius,
    ));
    final couponPath = Path.combine(
      PathOperation.reverseDifference,
      clipPath,
      frameCoupon,
    );

    return couponPath;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
