part of '../core.dart';

enum _LoadingKind { none, spinner, progress }

class WidgetUtils {
  static _LoadingKind _kind = _LoadingKind.none;
  static int _pendingProgress = 0;
  static String? _pendingStatus;

  /// Shows loading overlay and blocks taps underneath.
  static Future<void> showLoading({String? status, Widget? indicator}) {
    if (_kind == _LoadingKind.progress && EasyLoading.isShow) {
      return Future.value();
    }
    _kind = _LoadingKind.spinner;
    return _showEasyLoading(status: status, indicator: indicator);
  }

  /// Same mask as [showLoading], with a percent ring.
  ///
  /// Stays up until [dismissProgressLoading]. Calling again
  /// only updates percent/label — it does not dismiss (EasyLoading.show would
  /// tear down the mask and let taps through). [dismissLoading] will not
  /// steal this overlay.
  static Future<void> showProgressLoading({String? status, int progress = 0}) {
    final alreadyShowing = _kind == _LoadingKind.progress && EasyLoading.isShow;
    _kind = _LoadingKind.progress;
    _pendingProgress = progress < 0 ? 0 : (progress > 100 ? 100 : progress);
    if (status != null) {
      _pendingStatus = status;
    }
    if (alreadyShowing) {
      return Future.value();
    }
    return _showEasyLoading(
      status: '',
      indicator: const _ProgressLoadingIndicator(),
    );
  }

  static void updateProgressLoading(int progress, {String? status}) {
    if (_kind != _LoadingKind.progress) {
      return;
    }
    _pendingProgress = progress < 0 ? 0 : (progress > 100 ? 100 : progress);
    if (status != null) {
      _pendingStatus = status;
    }
  }

  /// Wired on every [AppBaseRepo] post/put/patch. Does not rebuild the overlay.
  static void onSendProgress(int sentBytes, int totalBytes) {
    if (_kind != _LoadingKind.progress || totalBytes <= 0) {
      return;
    }
    _pendingProgress = ((sentBytes / totalBytes) * 100).round().clamp(0, 100);
  }

  static void syncProgressLoading({
    required bool isActive,
    int progress = 0,
    String? status,
  }) {
    if (isActive) {
      showProgressLoading(status: status, progress: progress);
      return;
    }
    dismissProgressLoading();
  }

  static Future<void> dismissProgressLoading() {
    if (_kind != _LoadingKind.progress) {
      return Future.value();
    }
    return _dismissEasyLoading();
  }

  /// Dismisses the spinner overlay only. Does not tear down
  /// [showProgressLoading] — route-pop `dispose` (PDF preview) and global
  /// error handlers used to call this while create POST was still running.
  static Future<void> dismissLoading() {
    if (_kind == _LoadingKind.progress) {
      return Future.value();
    }
    return _dismissEasyLoading();
  }

  static Future<void> _dismissEasyLoading() {
    _kind = _LoadingKind.none;
    _pendingProgress = 0;
    _pendingStatus = null;
    return EasyLoading.dismiss();
  }

  static Future<void> _showEasyLoading({String? status, Widget? indicator}) {
    final instance = EasyLoading.instance
      ..userInteractions = false
      ..dismissOnTap = false;
    final maskType = instance.maskType == EasyLoadingMaskType.none
        ? EasyLoadingMaskType.clear
        : instance.maskType;
    return EasyLoading.show(
      maskType: maskType,
      status: status,
      indicator: indicator,
    );
  }

  static OverlayEntry? _activeSnackBar;

  static void showSnackBar({
    EdgeInsetsGeometry? margin,
    required BuildContext context,
    required Color color,
    required Color backgroundColor,
    TextStyle? textStyle,
    required String title,
    Duration? duration,
    Widget? icon,
    DismissDirection? dismissDirection,
    String? actionLabel,
    VoidCallback? onAction,
    TextStyle? actionTextStyle,
  }) {
    _dismissActiveSnackBar();
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => _TopSnackBar(
        title: title,
        color: color,
        backgroundColor: backgroundColor,
        icon: icon,
        duration: duration ?? const Duration(seconds: 3),
        textStyle: textStyle,
        margin: margin,
        actionLabel: actionLabel,
        onAction: onAction,
        actionTextStyle: actionTextStyle,
        onDismissed: () {
          if (identical(_activeSnackBar, overlayEntry)) {
            _activeSnackBar = null;
          }
          if (overlayEntry.mounted) {
            overlayEntry.remove();
          }
        },
      ),
    );

    _activeSnackBar = overlayEntry;
    overlay.insert(overlayEntry);
  }

  static void _dismissActiveSnackBar() {
    final current = _activeSnackBar;
    _activeSnackBar = null;
    if (current != null && current.mounted) {
      current.remove();
    }
  }

  static void configLoading(Widget logo) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..textColor = Colors.white
      ..radius = 10
      ..indicatorType = EasyLoadingIndicatorType.rotatingCircle
      ..indicatorColor = Colors.transparent
      ..userInteractions = false
      ..indicatorWidget = BrandLoading(logoDark: false, logo: logo)
      ..boxShadow = <BoxShadow>[]
      ..maskColor = Colors.black.withValues(alpha: 0.6)
      ..backgroundColor = Colors.transparent
      ..maskType = EasyLoadingMaskType.custom
      ..dismissOnTap = false;
  }
}

class _ProgressLoadingIndicator extends StatefulWidget {
  const _ProgressLoadingIndicator();

  @override
  State<_ProgressLoadingIndicator> createState() =>
      _ProgressLoadingIndicatorState();
}

class _ProgressLoadingIndicatorState extends State<_ProgressLoadingIndicator> {
  Timer? _timer;
  int _progress = 0;
  String? _status;

  @override
  void initState() {
    super.initState();
    _progress = WidgetUtils._pendingProgress;
    _status = WidgetUtils._pendingStatus;
    _timer = Timer.periodic(const Duration(milliseconds: 80), (_) {
      if (!mounted) {
        return;
      }
      final nextProgress = WidgetUtils._pendingProgress;
      final nextStatus = WidgetUtils._pendingStatus;
      if (nextProgress == _progress && nextStatus == _status) {
        return;
      }
      setState(() {
        _progress = nextProgress;
        _status = nextStatus;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = _status?.trim();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null && label.isNotEmpty) ...[
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
        ],
        SizedBox(
          width: 88,
          height: 88,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 88,
                height: 88,
                child: CircularProgressIndicator(
                  value: (_progress / 100).clamp(0.0, 1.0),
                  strokeWidth: 6,
                  color: Colors.white,
                  backgroundColor: const Color(0x40FFFFFF),
                ),
              ),
              Text(
                '$_progress%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BrandLoading extends StatelessWidget {
  final bool logoDark;
  final double? size;
  final Widget logo;

  const BrandLoading({
    super.key,
    this.logoDark = false,
    required this.logo,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sizeLoading = size ?? screenWidth * 0.25;

    return Stack(
      alignment: Alignment.center,
      children: [
        SpinKitSpinningLines(
          color: logoDark ? Colors.white : const Color(0xFF016829),
          size: sizeLoading * 0.9,
          lineWidth: 3,
          duration: const Duration(milliseconds: 1200),
        ),
        Container(
          width: sizeLoading * 0.5,
          height: sizeLoading * 0.5,
          decoration: const ShapeDecoration(
            color: Colors.transparent,
            shape: CircleBorder(),
          ),
          child: logo,
        ),
      ],
    );
  }
}

class _TopSnackBar extends StatefulWidget {
  final String title;
  final Color color;
  final Color backgroundColor;
  final Widget? icon;
  final Duration duration;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? margin;
  final VoidCallback onDismissed;
  final String? actionLabel;
  final VoidCallback? onAction;
  final TextStyle? actionTextStyle;

  const _TopSnackBar({
    required this.title,
    required this.color,
    required this.backgroundColor,
    this.icon,
    required this.duration,
    this.textStyle,
    this.margin,
    required this.onDismissed,
    this.actionLabel,
    this.onAction,
    this.actionTextStyle,
  });

  @override
  State<_TopSnackBar> createState() => _TopSnackBarState();
}

class _TopSnackBarState extends State<_TopSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  Timer? _timer;
  bool _isDismissing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 280),
      reverseDuration: const Duration(milliseconds: 220),
      vsync: this,
    );

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0.0, -1.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          ),
        );

    _controller.forward();

    _timer = Timer(widget.duration, () {
      _dismiss();
    });
  }

  void _dismiss() {
    if (!mounted || _isDismissing) {
      return;
    }
    _isDismissing = true;
    _timer?.cancel();
    _controller.reverse().whenComplete(() {
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _snackBarBorderColor(widget.backgroundColor),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                if (widget.icon != null) ...[
                  widget.icon!,
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    widget.title,
                    style:
                        widget.textStyle ??
                        GoogleFonts.barlow(
                          color: widget.color,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    _timer?.cancel();
                    _dismiss();
                  },
                  child: Icon(Icons.close, color: widget.color, size: 20),
                ),
                if (widget.onAction != null && widget.actionLabel != null) ...[
                  const SizedBox(width: 12),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      widget.onAction?.call();
                      _timer?.cancel();
                      _dismiss();
                    },
                    child: Text(
                      widget.actionLabel!,
                      style:
                          widget.actionTextStyle ??
                          widget.textStyle?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ) ??
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color _snackBarBorderColor(Color background) {
  final hsl = HSLColor.fromColor(background);
  return hsl.withLightness((hsl.lightness - 0.18).clamp(0.0, 1.0)).toColor();
}
