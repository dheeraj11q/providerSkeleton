import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:providerskeleton/app/app_key.dart';

void appSnackBar({
  @required String? content,
  Color? background,
  Color? textColor,
  Duration? duration,
  flashStyle = FlashBehavior.floating,
}) {
  showFlash(
    context: App.materialKey.currentContext!,
    duration: duration ?? const Duration(seconds: 2),
    builder: (context, controller) {
      return Flash(
        backgroundColor: background ?? Colors.black,
        controller: controller,
        behavior: flashStyle,
        position: FlashPosition.bottom,
        boxShadows: kElevationToShadow[4],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(
          content: Text(
            content!,
            style: TextStyle(color: textColor ?? Colors.white),
          ),
        ),
      );
    },
  );
}
