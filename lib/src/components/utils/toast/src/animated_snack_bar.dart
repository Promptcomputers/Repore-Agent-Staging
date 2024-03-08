import 'package:flutter/material.dart';
import 'package:repore_agent/src/components/utils/toast/src/types.dart';
import 'package:repore_agent/src/components/utils/toast/src/widget/material_animated_snack_bar.dart';
import 'package:repore_agent/src/components/utils/toast/src/widget/raw_animated_snack_bar.dart';
import 'package:repore_agent/src/components/utils/toast/src/widget/rectangle_animated_snack_bar.dart';

class AnimatedSnackBar {
  final Duration duration;

  final WidgetBuilder builder;

  final MobileSnackBarPosition mobileSnackBarPosition;

  final DesktopSnackBarPosition desktopSnackBarPosition;

  AnimatedSnackBar({
    this.duration = const Duration(seconds: 8),
    this.mobileSnackBarPosition = MobileSnackBarPosition.top,
    this.desktopSnackBarPosition = DesktopSnackBarPosition.bottomLeft,
    required this.builder,
  });

  /// Creates a material style snack bar.
  /// Remember to call [show] method to show the snack bar.
  factory AnimatedSnackBar.material(
    String messageText, {
    required AnimatedSnackBarType type,
    BorderRadius? borderRadius,
    DesktopSnackBarPosition desktopSnackBarPosition =
        DesktopSnackBarPosition.bottomLeft,
    MobileSnackBarPosition mobileSnackBarPosition = MobileSnackBarPosition.top,
    Duration duration = const Duration(seconds: 8),
  }) {
    final WidgetBuilder builder = ((context) {
      return MaterialAnimatedSnackBar(
        type: type,
        borderRadius: borderRadius ?? defaultBorderRadius,
        messageText: messageText,
      );
    });

    return AnimatedSnackBar(
      duration: duration,
      builder: builder,
      desktopSnackBarPosition: desktopSnackBarPosition,
      mobileSnackBarPosition: mobileSnackBarPosition,
    );
  }

  factory AnimatedSnackBar.rectangle(
    String titleText,
    String messageText, {
    required AnimatedSnackBarType type,
    DesktopSnackBarPosition desktopSnackBarPosition =
        DesktopSnackBarPosition.bottomLeft,
    MobileSnackBarPosition mobileSnackBarPosition = MobileSnackBarPosition.top,
    Duration duration = const Duration(seconds: 8),
    Brightness? brightness,
  }) {
    final WidgetBuilder builder = ((context) {
      return RectangleAnimatedSnackBar(
        titleText: titleText,
        messageText: messageText,
        type: type,
        brightness: brightness ?? Theme.of(context).brightness,
      );
    });

    return AnimatedSnackBar(
      duration: duration,
      builder: builder,
      desktopSnackBarPosition: desktopSnackBarPosition,
      mobileSnackBarPosition: mobileSnackBarPosition,
    );
  }

  /// This method will create an overlay for your snack bar
  /// and insert it to the overlay entries of navigator.
  Future<void> show(BuildContext context) async {
    final overlay = Navigator.of(context).overlay!;
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => RawAnimatedSnackBar(
        duration: duration,
        onRemoved: entry.remove,
        desktopSnackBarPosition: desktopSnackBarPosition,
        mobileSnackBarPosition: mobileSnackBarPosition,
        child: builder.call(context),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => overlay.insert(entry),
    );
    await Future.delayed(duration);
  }
}
