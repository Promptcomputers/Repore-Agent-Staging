import 'package:flutter/material.dart';
import 'package:repore_agent/lib.dart';

class BottomExpandedViewWidget extends StatelessWidget {
  final Widget child;
  final double? radius;
  final Color? color;
  final double? left, right, bottom, top;
  final ScrollPhysics? physics;
  const BottomExpandedViewWidget({
    required this.child,
    this.radius,
    this.color,
    Key? key,
    this.left,
    this.right,
    this.bottom,
    this.top,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color ?? AppColors.homeContainerBorderColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              radius ?? 20.r,
            ),
          ),
        ),
        child: SingleChildScrollView(
          physics: physics ?? AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            left: left ?? 20.w,
            right: right ?? 20.w,
            top: top ?? 30.h,
            bottom: bottom ?? 80.h,
          ),
          child: child,
        ),
      ),
    );
  }
}
