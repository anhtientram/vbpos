part of '../core.dart';

enum SnackBarPosition { top, bottom }

SnackBar snackBarWidget({
  Duration? duration,
  EdgeInsetsGeometry? padding, // Padding
  EdgeInsetsGeometry? paddingIcon, // Padding icon
  EdgeInsetsGeometry? margin, //margin
  Widget? iconHeader, // Icon
  required String title, // Title
  TextStyle? textStyle, // Text Style of title
  Color? color, // Color
  TextStyle? clickTextStyle, // Text Style of click text
  // required BuildContext context,
  bool showHeaderIcon = true,
  bool showBottomIcon = true,
  DismissDirection? dismissDirection,
  SnackBarPosition position = SnackBarPosition.bottom,
  Color? backgroundColor,
  required ScaffoldMessengerState controller,
}) {
  return SnackBar(
    // margin: margin ??
    //     (position == SnackBarPosition.top
    //         ? EdgeInsets.only(bottom: AppDeviceUtils.getHeight3(context) - 56 * 2)
    //         : EdgeInsets.zero),
    behavior: SnackBarBehavior.floating,
    duration: duration ?? const Duration(seconds: 5),
    padding: EdgeInsets.zero,
    dismissDirection: dismissDirection ?? DismissDirection.up,
    backgroundColor: backgroundColor,
    content: SizedBox(
      height: 56,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Visibility(
                  visible: showHeaderIcon,
                  child: Container(
                    padding:
                        paddingIcon ??
                        const EdgeInsets.symmetric(horizontal: 12),
                    child:
                        iconHeader ??
                        Icon(Icons.check_circle, color: color, size: 24),
                  ),
                ),
                Flexible(
                  child: Text(
                    title,
                    style: textStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: showBottomIcon,
            child: IconButton(
              onPressed: () {
                controller.hideCurrentSnackBar();
              },
              icon: Icon(Icons.close, color: color, size: 20),
            ),
          ),
        ],
      ),
    ),
  );
}
