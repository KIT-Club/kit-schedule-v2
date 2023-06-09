import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/export.dart';

import 'flash.dart';

void showTopSnackBar(BuildContext context,
    {SnackBarType type = SnackBarType.warning,
    required String message,
    Duration duration = const Duration(seconds: 2)}) {
  showFlash(
      context: context,
      duration: const Duration(seconds: 2),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          barrierDismissible: true,
          behavior: FlashBehavior.floating,
          position: FlashPosition.top,
          child: AppSnackBarWidget(
            type: type,
            message: message,
          ),
        );
      });
}

class AppSnackBarWidget extends StatelessWidget {
  final SnackBarType type;
  final String message;

  const AppSnackBarWidget({
    Key? key,
    this.type = SnackBarType.warning,
    required this.message,
  }) : super(key: key);

  String get iconPath {
    switch (type) {
      case SnackBarType.done:
        return ImageConstants.icSuccess;
      case SnackBarType.error:
        return ImageConstants.icFailed;
      default:
        return ImageConstants.icWarning;
    }
  }

  Color? get backgroundColor {
    switch (type) {
      case SnackBarType.done:
        return AppColors.green50;
      case SnackBarType.error:
        return AppColors.red50;
      default:
        return AppColors.orange50;
    }
  }

  Color? get textColor {
    switch (type) {
      case SnackBarType.done:
        return AppColors.green;
      case SnackBarType.error:
        return AppColors.red;
      default:
        return AppColors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimens.space_16),
      decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.all(Radius.circular(AppDimens.radius_12)),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: backgroundColor!,
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ]),
      padding: EdgeInsets.all(AppDimens.space_12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImageWidget(
            path: iconPath,
            width: AppDimens.space_20,
            height: AppDimens.space_20,
            //   color: textColor,
          ),
          SizedBox(
            width: AppDimens.space_12,
          ),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: textColor),
            ),
          )
        ],
      ),
    );
  }
}
