import 'package:flutter/material.dart';
import 'package:repore_agent/lib.dart';
import 'package:repore_agent/src/components/utils/toast/src/types.dart';

const _infoBackgroundColor = Color.fromRGBO(80, 147, 209, 1);
const _errorBackgrounColor = AppColors.redColor;
const _successBackgroundColor = AppColors.greenColor;
final _warningBackgroundColor = AppColors.redColor.withOpacity(0.5);
// final _warningBackgroundColor = AppColors.failedRed;

final defaultBorderRadius = BorderRadius.circular(8);

class MaterialAnimatedSnackBar extends StatelessWidget {
  const MaterialAnimatedSnackBar({
    Key? key,
    required this.type,
    required this.borderRadius,
    required this.messageText,
  }) : super(key: key);

  final AnimatedSnackBarType type;
  final BorderRadius borderRadius;
  final String messageText;

  Color get foregroundColor => Colors.white;

  Color get backgroundColor {
    switch (type) {
      case AnimatedSnackBarType.info:
        return _infoBackgroundColor;

      case AnimatedSnackBarType.error:
        return _errorBackgrounColor;

      case AnimatedSnackBarType.success:
        return _successBackgroundColor;

      case AnimatedSnackBarType.warning:
        return _warningBackgroundColor;

      default:
        throw UnimplementedError();
    }
  }

  IconData get iconData {
    switch (type) {
      case AnimatedSnackBarType.info:
        return Icons.info_outline;

      case AnimatedSnackBarType.error:
        return Icons.error_outline;

      case AnimatedSnackBarType.success:
        return Icons.done;

      case AnimatedSnackBarType.warning:
        return Icons.warning_amber_rounded;

      default:
        throw UnimplementedError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  Text(
                    messageText,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: foregroundColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
