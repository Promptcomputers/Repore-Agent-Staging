import 'package:flutter/material.dart';
import 'package:repore_agent/lib.dart';

extension DimsExtension on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;
  double deviceWidth([double extent = 1]) => mediaQuerySize.width * extent;
  double deviceHeight([double extent = 1]) => mediaQuerySize.height * extent;
  Orientation get deviceOrientation => MediaQuery.of(this).orientation;
  bool get isLandscape => deviceOrientation == Orientation.landscape;
  bool get isPortrait => deviceOrientation == Orientation.portrait;
}

class XBox extends StatelessWidget {
  final double _width;

  const XBox(this._width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width.w,
    );
  }
}

class YBox extends StatelessWidget {
  final double _height;

  const YBox(this._height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height.h,
    );
  }
}

class AppDivider extends StatelessWidget {
  const AppDivider(this.indent, {this.color, this.thickness, Key? key})
      : super(key: key);

  final double indent;
  final Color? color;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? AppColors.textFormFieldBorderColor,
      indent: indent,
      endIndent: indent,
      thickness: thickness ?? 1.4.w,
    );
  }
}
